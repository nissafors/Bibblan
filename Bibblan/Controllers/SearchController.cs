using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;
using Services.Services;

namespace Bibblan.Controllers
{
    public class SearchController : Controller
    {
        private BookAuthorServices _bookServices = new BookAuthorServices();

        public SearchController()
        {
            IEnumerable<SelectListItem> classification = new SelectList(Mockup.classifications, "Id", "Signum");
            ViewData["classifications-list"] = classification;
        }

        //
        // GET: /Search/
        public ActionResult Results()
        {
            return View();
        }

        public ActionResult Borrower()
        {
            return View(Services.Mockup.Mockup.borrowers[1]);
        }

        //
        // GET: /Search/
        public ActionResult Author(Author author = null)
        {
            ViewBag.books = _bookServices.GetBookAuthors(author);

            return View(author);
        }

        public ActionResult Book()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Book(Book book)
        {
            List<BookAuthor> bookauthors = _bookServices.GetBookAuthors(book);
            ViewBag.books = bookauthors;
            return View(book);
        }
    }
}