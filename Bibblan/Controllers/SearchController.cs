using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;

namespace Bibblan.Controllers
{
    public class SearchController : Controller
    {
        //
        // GET: /Search/
        public ActionResult Results()
        {
            return View();
        }

        public ActionResult Borrower()
        {
            return View();
        }

        //
        // GET: /Search/
        public ActionResult Author()
        {
            return View();
        }

        public ActionResult Book()
        {
            ViewData["cList"] = Services.Mockup.Mockup.classifications;
            Book book = Services.Mockup.Mockup.books[0];
            return View(book);
        }
	}
}