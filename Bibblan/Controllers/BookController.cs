using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Services.Services;

namespace Bibblan.Controllers
{
    public class BookController : Controller
    {
        BookAuthorServices _bookAuthorServices = new BookAuthorServices();
        //
        // GET: /Book/
        public ActionResult Details(string isbn)
        {
            return View(_bookAuthorServices.GetBookAuthorByISBN(isbn));
        }
	}
}