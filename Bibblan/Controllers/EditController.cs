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

        public ActionResult Book(BookAuthor bookAuthor = null)
        {
            // Debug
            bookAuthor = Mockup.bookAuthors[2];

            SelectList authors = new SelectList((from s in Mockup.authors
                                                select new
                                                {
                                                    Id = s.Id,
                                                    FullName = s.FirstName + " " + s.LastName
                                                }), "Id", "FullName", bookAuthor.Author.Id);
            ViewData["author"] = authors;

            IEnumerable<SelectListItem> classifications = new SelectList(Mockup.classifications, "Id", "Signum");
            ViewData["classification"] = classifications;

            return View(bookAuthor);
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

        public ActionResult Author()
        {
            Common.Models.Author author = Services.Mockup.Mockup.authors[0];
            return View(author);
        }
    }
}