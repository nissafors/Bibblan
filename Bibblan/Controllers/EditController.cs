using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;

namespace Bibblan.Controllers
{
    public class EditController : Controller
    {
        // GET: Edit
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Book(Book book = null)
        {
            // Debug
            //book = Mockup.books[2];

            IEnumerable<BookAuthor> bookAuthors = from ba in Mockup.bookAuthors where ba.Book == book select ba;
            int authorId = bookAuthors.Count() > 0 ? bookAuthors.ElementAt(0).Author.Id : 0;

            SelectList authors = new SelectList((from s in Mockup.authors
                                                select new
                                                {
                                                    Id = s.Id,
                                                    FullName = s.FirstName + " " + s.LastName
                                                }), "Id", "FullName", authorId);
            ViewData["author"] = authors;

            IEnumerable<SelectListItem> classifications = new SelectList(Mockup.classifications, "Id", "Signum");
            ViewData["classification"] = classifications;

            return View(book);
        }

        public ActionResult Copy(Copy copy = null)
        {
            IEnumerable<SelectListItem> statuses = new SelectList(Mockup.statuses, "Id", "StatusName");
            ViewData["statuses"] = statuses;

            return View(copy);
        }

        public ActionResult Borrower()
        {
            return View();
        }

        public ActionResult Author(int id)
        {
            //Common.Models.Author author = Services.Mockup.Mockup.authors[0];
            Author author = Services.Services.AuthorServices.getAuthorById(id);
            if(author != null)
                return View(author);

            return View();
        }
    }
}