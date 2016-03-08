using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Services;
using System.Diagnostics;

namespace Bibblan.Controllers
{
    public class SearchController : Controller
    {
        // Update or add borrower
        public ActionResult Borrower(string search)
        {
            if(!AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
            {
                if(Request.UrlReferrer != null)
                    return Redirect(Request.UrlReferrer.ToString());
                else
                    return RedirectToAction("Index", "Home");
            }

            if (search != null)
            {
                ViewBag.result = BorrowerServices.SearchBorrowers(search);
            }
            return View();
        }
        

        //
        // POST: /Search/
        /*
        [HttpPost]
        public ActionResult Author(SearchAuthorViewModel model)
        {
            ViewBag.result = new ResultViewModel(model.getAuthor());
            return View(model);
        }
        */
        //
        // GET: /Search/
        /*
        public ActionResult Author(SearchAuthorViewModel model)
        {
            if (ViewHelper.isQueryMapped(model, Request.QueryString))
                ViewBag.result = new ResultViewModel(model.getAuthor());
            else
                ViewBag.result = null;

            return View(model);
        }
        */
        public ActionResult Book(string search)
        {
            if (search == null)
                ViewBag.result = null;
            else
            {
                List<BookViewModel> model;
                model = BookServices.SearchBooks(search);
                ViewBag.result = model;
            }
            if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                ViewBag.isAdmin = true;
            else
                ViewBag.isAdmin = false;

            return View();
        }
        /*
        [HttpPost]
        public ActionResult Book(SearchBookViewModel model)
        {
            ViewBag.result = new ResultViewModel(model.getBook());
            return View(model);
        }
        */
    }
}