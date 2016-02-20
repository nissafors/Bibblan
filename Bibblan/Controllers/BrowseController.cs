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
        AuthorServices _authorServices = new AuthorServices();
        BookServices _bookServices = new BookServices();

        //
        // GET: /Browse/Title
        public ActionResult Title()
        {
            ViewBag.books = _bookServices.GetBooks();
            return View();
        }

        //
        // GET: /Browse/Author
        public ActionResult Author()
        {
            ViewBag.authors = _authorServices.GetAuthors();
            return View();
        }
	}
}