using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Services;
using Bibblan.Helpers;
using Bibblan.Filters;
using Services.Exceptions;

namespace Bibblan.Controllers
{
    public class EditController : Controller
    {
        // GET: edit/book
        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Book(string isbn)
        {
            var bookInfo = new EditBookViewModel();

            if (isbn != null)
            {
                try
                {
                    bookInfo = BookServices.GetEditBookViewModel(isbn);
                    bookInfo.Update = true;
                }
                catch (NoSuchAuthorException e) { ViewBag.error = e.Message; }
                catch (AlreadyExistsException e) { ViewBag.error = e.Message; }
                catch (Exception) { ViewBag.error = "Oväntat fel."; }
            }

            setBookViewLists(bookInfo);

            return View(bookInfo);
        }

        // Always check Actual role against Repository (ForceCheck = true)
        // When making changes
        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Book(EditBookViewModel bookInfo)
        {
            setBookViewLists(bookInfo);

            if (ModelState.IsValid)
            {
                try
                {
                    BookServices.Upsert(bookInfo, bookInfo.Update);
                    bookInfo.Update = true;
                }
                catch (AlreadyExistsException e) { ViewBag.error = e.Message; }
                catch (NoSuchAuthorException e) { ViewBag.error = e.Message; }
                catch (DataAccessException e) { ViewBag.error = e.Message; }
                catch (Exception) { ViewBag.error = "Oväntat fel."; }
            }

            return View(bookInfo);
        }

        // Helper for the Book ActionResult's.
        private void setBookViewLists(EditBookViewModel ebvm)
        {
            ebvm.Copies = CopyServices.getCopyViewModels(ebvm.ISBN);

            var classDic = ClassificationServices.GetClassificationsAsDictionary();
            var authorDic = AuthorServices.GetAuthorsAsDictionary();
            ebvm.Classifications = new SelectList(classDic.OrderBy(x => x.Value), "Key", "Value");
            ebvm.Authors = new SelectList(authorDic.OrderBy(x => x.Value), "Key", "Value");
        }

        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Copy(string isbn, string barcode)
        {
            // We must have an ISBN number.
            if (isbn == null)
            {
                TempData["error"] = "Kan endast skapa exemplar av existerande böcker.";
                return RedirectToAction("AdminPage", "Account");
            }

            // Is this ISBN valid?
            try
            {
                BookServices.GetBookDetails(isbn);
            }
            catch (DoesNotExistException e)
            {
                TempData["error"] = e.Message;
                return RedirectToAction("AdminPage", "Account");
            }
            catch (DataAccessException e)
            {
                TempData["error"] = e.Message;
                return RedirectToAction("AdminPage", "Account");
            }

            CopyViewModel cvm = new CopyViewModel();

            // If a barcode was given; is it valid?
            if (barcode != null) {
                try
                {
                    cvm = CopyServices.GetCopyViewModel(barcode);
                    cvm.Update = true;
                }
                catch (DoesNotExistException e)
                {
                    ViewBag.error = e.Message;
                }
            }

            cvm.ISBN = isbn;
            setCopyViewLists(cvm);

            return View(cvm);
        }

        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Copy(CopyViewModel copyInfo)
        {
            if (!ModelState.IsValid)
            {
                setCopyViewLists(copyInfo);
                return View(copyInfo);
            }

            try
            {
                CopyServices.Upsert(copyInfo, copyInfo.Update);
                return RedirectToAction("Book", new { copyInfo.ISBN });
            }
            catch (Exception e)
            {
                ViewBag.error = e.Message;
                setCopyViewLists(copyInfo);
                return View(copyInfo);
            }

        }

        private void setCopyViewLists(CopyViewModel cvm)
        {
            var statusDic = StatusServices.GetStatusesAsDictionary();
            cvm.Statuses = new SelectList(statusDic.OrderBy(x => x.Value), "Key", "Value");
            cvm.Title = BookServices.GetBookDetails(cvm.ISBN).Title;
        }

        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Borrower(string PersonId)
        {
            BorrowerViewModel borrower = new BorrowerViewModel();
            if (PersonId == null)
            {
                borrower.New = true;
            }
            else
            {
                borrower = BorrowerServices.GetBorrower(PersonId);
                borrower.New = false;
            }
            setBorrowerViewLists(borrower);
            return View(borrower);
        }

        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Borrower(BorrowerViewModel borrower)
        {
            if (TempData["error"] != null)
            {
                ViewBag.error = TempData["error"].ToString();
                TempData["error"] = null;
            }

            try
            {
                BorrowerServices.Upsert(borrower);
                borrower.New = false;
            }
            catch(AlreadyExistsException e)
            {
                ViewBag.error = e.Message;
            }
            catch(DoesNotExistException e)
            {
                ViewBag.error = e.Message;
            }
            catch(Exception)
            {
                // TODO: Handle general exception
            }

            setBorrowerViewLists(borrower);
            return View(borrower);
        }

        private void setBorrowerViewLists(BorrowerViewModel borrower)
        {
            var categoryDic = CategoryServices.GetCategoriesAsDictionary();
            borrower.Category = new SelectList(categoryDic.OrderBy(x => x.Value), "Key", "Value");
        }

        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Renew(BorrowViewModel borrowViewModel)
        {
            BorrowServices.Renew(borrowViewModel);
            return Redirect(Request.UrlReferrer.ToString());
        }

        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Delete(string Type, string Id)
        {
            Type = Type.ToLower();
            try
            {
                switch (Type)
                {
                    case "borrower":
                        BorrowerServices.Delete(Id);
                        return RedirectToAction("Borrower", "Search");

                    case "author":
                        AuthorServices.DeleteAuthor(Id);
                        return RedirectToAction("Author", "Search");

                    case "book":
                        BookServices.Delete(Id);
                        return RedirectToAction("Book", "Search");

                    case "copy":
                        var isbn = CopyServices.GetCopyViewModel(Id).ISBN;
                        CopyServices.DeleteCopy(Id);
                        return RedirectToAction("Book", new { isbn });

                    default:
                        return RedirectToAction("Index", "Home");

                }
            }
            catch (HasBooksException e)
            {
                string authorId = Id;
                TempData["error"] = e.Message;
                return RedirectToAction("Author", new { authorId });
            }
            catch(DoesNotExistException e)
            {
                TempData["error"] = e.Message;
                
                return RedirectToAction("Index", "Home");
            }
            catch (Exception)
            {
                TempData["error"] = "Ett oväntat fel uppstod när ett objekt skulle tas bort.";

                return RedirectToAction("Index", "Home");
            }
        }

        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Author(int? authorid)
        {
            AuthorViewModel author = new AuthorViewModel();

            if (TempData["error"] != null)
            {
                ViewBag.error = TempData["error"].ToString();
                TempData["error"] = null;
            }

            try
            {
                if (authorid != null)
                {
                    author = AuthorServices.GetAuthor((int)authorid);
                }
            }
            catch(DoesNotExistException e)
            {
                ViewBag.error = e.Message;
            }

            return View(author);
        }

        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Author(AuthorViewModel authorViewModel)
        {
            try
            {
                AuthorServices.Upsert(authorViewModel);
            }
            catch(AlreadyExistsException e)
            {
                ViewBag.error = e.Message;
            }
            catch(DoesNotExistException e)
            {
                ViewBag.error = e.Message;
            }
            catch(Exception)
            {
                // TODO: Handle general error
            }
            
            return View(authorViewModel);
        }
    }
}