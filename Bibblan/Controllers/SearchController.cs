using Bibblan.Filters;
using Bibblan.Helpers;
using Common.Models;
using Services.Exceptions;
using Services.Services;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
    public class SearchController : Controller
    {
        /// <summary>
        /// GET: /Search/Borrower. Show search form for borrowers.
        /// </summary>
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Borrower(string search)
        {
            if (search != null)
            {
                try
                {
                    List<BorrowerViewModel> borrowerList = BorrowerServices.SearchBorrowers(search);
                    ViewBag.result = borrowerList;
                    ViewBag.listCount = borrowerList.Count;
                }
                catch (DataAccessException e) { ViewBag.error = e.Message; }
            }

            return View();
        }
        
        /// <summary>
        /// GET: /Search/Book. Show search form for books.
        /// </summary>
        public ActionResult Book(string search)
        {
            if (search != null)
            {
                try
                {
                    List<BookViewModel> bookList = BookServices.SearchBooks(search);
                    ViewBag.result = bookList;
                    ViewBag.listCount = bookList.Count;

                    if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                        ViewBag.isAdmin = true;
                    else
                        ViewBag.isAdmin = false;
                }
                catch(DataAccessException e)
                {
                    ViewBag.error = e.Message;
                }
            }

            return View();
        }

        /// <summary>
        /// GET: /Search/Author. Show search form for authors.
        /// </summary>
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Author(string search)
        {
            if (search != null)
            {
                
                try
                {
                    List<AuthorViewModel> authorList = AuthorServices.SearchAuthors(search);
                    ViewBag.result = authorList;
                    ViewBag.listCount = authorList.Count;
                }
                catch (DataAccessException e) { ViewBag.error = e.Message; }
            }

            return View();
        }
    }
}