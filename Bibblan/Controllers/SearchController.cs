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
        private BookServices _bookServices = new BookServices();

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
            return View();
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
            //ViewData["cList"] = Services.Mockup.Mockup.classifications;
            Book book = Services.Mockup.Mockup.books[0];
            //return View(book);
            return View();
        }

        [HttpPost]
        public ActionResult Book(Book b)
        {
            List<BookAuthor> bookauthors = _bookServices.GetBookAuthors(b);
            List<Book> books = Mockup.books;
            ViewBag.books = books;
            return View(b);
        }
    }
}