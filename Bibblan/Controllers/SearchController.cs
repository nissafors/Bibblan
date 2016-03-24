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
                try { ViewBag.result = BorrowerServices.SearchBorrowers(search); }
                catch (DataAccessException e) { ViewBag.error = e.Message; }
            }

            return View();
        }
        
        /// <summary>
        /// GET: /Search/Book. Show search form for books.
        /// </summary>
        public ActionResult Book(string search)
        {
            if (search == null)
                ViewBag.result = null;
            else
            {
                try
                {
                    ViewBag.result = BookServices.SearchBooks(search);

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
            if (search == null)
                ViewBag.result = null;
            else
            {
                List<AuthorViewModel> model;
                try
                {
                    model = AuthorServices.SearchAuthors(search);
                    ViewBag.result = model;
                }
                catch (DataAccessException e) { ViewBag.error = e.Message; }
            }

            return View();
        }
    }
}