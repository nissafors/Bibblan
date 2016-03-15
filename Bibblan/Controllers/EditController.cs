﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Services;
using Bibblan.Helpers;
using Bibblan.Filters;

namespace Bibblan.Controllers
{
    public class EditController : Controller
    {
        // GET: edit/book
        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Book(string isbn)
        {
            EditBookViewModel bookInfo = BookServices.GetEditBookViewModel(isbn);
            bookInfo.Update = (isbn != null);
            setBookViewLists(bookInfo);
            TempData["BookUpdate"] = bookInfo.Update;

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
                catch (Exception e)
                {
                    ViewBag.error = e.Message;
                }
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
            var cvm = CopyServices.GetCopyViewModel(barcode);
            cvm.ISBN = isbn;
            cvm.Update = (barcode != null);

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
            BorrowerViewModel borrower = null;
            if (PersonId == null)
            {
                borrower = BorrowerServices.GetEmptyBorrower();
            }
            else
            {
                borrower = BorrowerServices.GetBorrower(PersonId);
            }

            return View(borrower);
        }

        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Borrower(BorrowerViewModel borrower)
        {
            if (BorrowerServices.Upsert(borrower))
            {
                // TODO: Handle succesfull or unsuccesfull 
                // TODO: Set history so back button works
            }
            borrower = BorrowerServices.GetBorrower(borrower.PersonId);
            return View(borrower);
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
            try
            {
                switch (Type)
                {
                    case "Borrower":
                        BorrowerServices.Delete(Id);
                        return RedirectToAction("Borrower", "Search");

                    case "Author":
                        AuthorServices.DeleteAuthor(Id);
                        return RedirectToAction("Author", "Search");

                    case "Book":
                        BookServices.Delete(Id);
                        return RedirectToAction("Book", "Search");

                    case "Copy":
                        var isbn = CopyServices.GetCopyViewModel(Id).ISBN;
                        CopyServices.DeleteCopy(Id);
                        return RedirectToAction("Book", new { isbn });

                    default:
                        return RedirectToAction("Index", "Home");

                }
            }
            catch (Services.Exceptions.HasBooksException e)
            {
                string authorId = Id;
                TempData["error"] = e.Message;
                return RedirectToAction("Author", new { authorId });
            }
            catch(Services.Exceptions.DoesNotExistException e)
            {
                ViewBag.error = e.Message;
                
                if (Request.UrlReferrer != null)
                {
                    return Redirect(Request.UrlReferrer.ToString());
                }
                else
                {
                    return RedirectToAction("Index", "Home");
                }
            }
            catch (Exception)
            {
                if (Request.UrlReferrer != null)
                {
                    return Redirect(Request.UrlReferrer.ToString());
                }
                else
                {
                    return RedirectToAction("Index", "Home");
                }
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
            catch(Services.Exceptions.DoesNotExistException e)
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
            catch(Services.Exceptions.DoesNotExistException e)
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