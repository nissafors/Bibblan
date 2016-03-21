using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Services;
using System.Diagnostics;
using Bibblan.Helpers;
using Bibblan.Filters;
using Services.Exceptions;

namespace Bibblan.Controllers
{
    public class SearchController : Controller
    {
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