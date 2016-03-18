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
        /// <summary>
        /// GET: Edit/Book and Edit/Book/{isbn}. Display a form to create or update books.
        /// </summary>
        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Book(string isbn)
        {
            var errors = new List<string>();
            var bookInfo = new EditBookViewModel();

            if (isbn != null)
            {
                try
                {
                    bookInfo = BookServices.GetEditBookViewModel(isbn);
                    bookInfo.Update = true;
                }
                catch (DoesNotExistException e) { errors.Add(e.Message); }
                catch (AlreadyExistsException e) { errors.Add(e.Message); }
                catch (DataAccessException e) { errors.Add(e.Message); }
            }

            string err = setBookViewLists(bookInfo);
            if (err != null)
                errors.Add(err);

            if (errors.Count > 0)
                ViewBag.error = errors;

            return View(bookInfo);
        }

        /// <summary>
        /// POST: Edit/Book. Writes bookInfo to database and display the edit book view.
        /// </summary>
        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Book(EditBookViewModel bookInfo)
        {
            string err = setBookViewLists(bookInfo);
            if (err != null)
                ViewBag.error = err + "\n";

            if (ModelState.IsValid)
            {
                try
                {
                    BookServices.Upsert(bookInfo, bookInfo.Update);
                    bookInfo.Update = true;
                }
                catch (AlreadyExistsException e) { ViewBag.error += e.Message; }
                catch (DoesNotExistException e) { ViewBag.error += e.Message; }
                catch (DataAccessException e) { ViewBag.error += e.Message; }
                catch (Exception) { ViewBag.error += "Oväntat fel."; }
            }

            return View(bookInfo);
        }

        /// <summary>
        /// GET: /Edit/Copy/{isbn}. Show a form to create and update copies of a book.
        /// </summary>
        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Copy(string isbn, string barcode)
        {
            var errors = new List<string>();

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
                catch (DoesNotExistException e) { errors.Add(e.Message); }
                catch (DataAccessException e) { errors.Add(e.Message); }
            }

            cvm.ISBN = isbn;
            string err = setCopyViewLists(cvm);
            if (err != null)
                errors.Add(err);

            if (errors.Count > 0)
                ViewBag.error = errors;

            return View(cvm);
        }

        /// <summary>
        /// POST: /edit/copy. Save copy to db and redirect to the edit book view.
        /// </summary>
        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Copy(CopyViewModel copyInfo)
        {
            if (!ModelState.IsValid)
            {
                string err = setCopyViewLists(copyInfo);
                if (err != null)
                    ViewBag.error = err;

                return View(copyInfo);
            }

            try
            {
                CopyServices.Upsert(copyInfo, copyInfo.Update);
                return RedirectToAction("Book", new { copyInfo.ISBN });
            }
            catch (Exception e)
            {
                var errors = new List<string>();
                errors.Add(e.Message);
                string err = setCopyViewLists(copyInfo);
                if (err != null)
                    errors.Add("err");

                ViewBag.error = errors;

                return View(copyInfo);
            }

        }

        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Borrower(string PersonId)
        {
            var errors = new List<string>();

            BorrowerViewModel borrower = new BorrowerViewModel();
            borrower.New = true;
            if (PersonId != null)
            {
                try
                {
                    borrower = BorrowerServices.GetBorrower(PersonId);
                    borrower.New = false;
                }
                catch (DoesNotExistException e) { errors.Add(e.Message); }
                catch (DataAccessException e) { errors.Add(e.Message); }
            }

            string err = setBorrowerViewLists(borrower);
            if (err != null)
                errors.Add(err);

            if (errors.Count > 0)
                ViewBag.error = errors;

            return View(borrower);
        }

        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Borrower(BorrowerViewModel borrower)
        {
            var errors = new List<string>();

            try
            {
                BorrowerServices.Upsert(borrower);
                borrower.New = false;
            }
            catch(AlreadyExistsException e)
            {
                errors.Add(e.Message);
            }
            catch(DoesNotExistException e)
            {
                errors.Add(e.Message);
            }
            catch(DataAccessException e)
            {
                errors.Add(e.Message);
            }

            string err = setBorrowerViewLists(borrower);
            if (err != null)
                errors.Add(err);

            if (errors.Count > 0)
                ViewBag.error = errors;

            return View(borrower);
        }

        private string setBorrowerViewLists(BorrowerViewModel borrower)
        {
            try
            {
                var categoryDic = CategoryServices.GetCategoriesAsDictionary();
                borrower.Category = new SelectList(categoryDic.OrderBy(x => x.Value), "Key", "Value");
            }
            catch (DataAccessException e)
            {
                borrower.Category = new SelectList(new List<SelectListItem>());
                return e.Message;
            }

            return null;
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
                        bool isbnFound;
                        string isbn = "";
                        try
                        {
                            isbn = CopyServices.GetCopyViewModel(Id).ISBN;
                            isbnFound = true;
                        }
                        catch (DoesNotExistException) { isbnFound = false; }
                        catch (DataAccessException) { isbnFound = false; }
                        
                        CopyServices.DeleteCopy(Id);

                        if (!isbnFound)
                        {
                            TempData["error"] = "Hittar inte tillbaka till boken som ett exemplar av raderades.";
                            return RedirectToAction("Index", "Home");
                        }

                        return RedirectToAction("Book", new { isbn });

                    default:
                        return RedirectToAction("Index", "Home");

                }
            }
            catch (DeleteException e)
            {
                string authorId = Id;
                TempData["error"] = e.Message;
                return RedirectToAction("Author", new { authorId });
            }
            catch (DoesNotExistException e)
            {
                TempData["error"] = e.Message;
                return RedirectToAction("Index", "Home");
            }
            catch (DataAccessException e)
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
            catch (DoesNotExistException e) { ViewBag.error = e.Message; }
            catch (DataAccessException e) { ViewBag.error = e.Message; }

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

        public ActionResult Account(string username)
        {

            return View();
        }

        /// <summary>
        /// Populate lists in an EditBookViewModel.
        /// </summary>
        /// <param name="ebvm">The EditBookViewModel.</param>
        /// <returns>Returns an error message or null, if no error occured.</returns>
        private string setBookViewLists(EditBookViewModel ebvm)
        {
            try
            {
                ebvm.Copies = CopyServices.getCopyViewModels(ebvm.ISBN);

                var classDic = ClassificationServices.GetClassificationsAsDictionary();
                var authorDic = AuthorServices.GetAuthorsAsDictionary();
                ebvm.Classifications = new SelectList(classDic.OrderBy(x => x.Value), "Key", "Value");
                ebvm.Authors = new SelectList(authorDic.OrderBy(x => x.Value), "Key", "Value");
            }
            catch (DataAccessException e)
            {
                if (ebvm.Copies == null) ebvm.Copies = new List<CopyViewModel>();
                if (ebvm.Classifications == null) ebvm.Classifications = new SelectList(new List<SelectListItem>());
                if (ebvm.Authors == null) ebvm.Authors = new SelectList(new List<SelectListItem>());
                return e.Message;
            }

            return null;
        }

        /// <summary>
        /// Populate Statuses and Title in a CopyViewModel.
        /// </summary>
        /// <param name="cvm">The CopyViewModel.</param>
        /// <returns>Returns an error message or null, if no error occured.</returns>
        private string setCopyViewLists(CopyViewModel cvm)
        {
            try
            {
                var statusDic = StatusServices.GetStatusesAsDictionary();
                cvm.Title = BookServices.GetBookDetails(cvm.ISBN).Title;
                cvm.Statuses = new SelectList(statusDic.OrderBy(x => x.Value), "Key", "Value");
            }
            catch (DataAccessException e)
            {
                if (cvm.Title == null)
                    cvm.Title = "";
                if (cvm.Statuses == null)
                    cvm.Statuses = new SelectList(new List<SelectListItem>());
                return e.Message;
            }

            return null;
        }
    }
}