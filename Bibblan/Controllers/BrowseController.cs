using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Services.Services;

namespace Bibblan.Controllers
{
    public class BrowseController : Controller
    {
        BookAuthorServices _bookAuthorServices = new BookAuthorServices();
        //
        // GET: /Browse/
        public ActionResult Title()
        {
            ViewBag.books = _bookAuthorServices.GetBookAuthors();
            return View();
        }

        public ActionResult Author()
        {
            ViewBag.authors = _bookAuthorServices.GetBookAuthors();
            return View();
        }
	}
}