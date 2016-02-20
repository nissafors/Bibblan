using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Bibblan.Models;
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
        // POST: /Search/
        [HttpPost]
        public ActionResult Author(SearchAuthorViewModel model)
        {
            ViewBag.result = new ResultViewModel(model.getAuthor());
            return View(model);
        }

        //
        // GET: /Search/
        public ActionResult Author()
        {
            /*
            ViewBag.books = _bookServices.GetBookAuthors(author);
            return View(new SearchAuthorViewModel(author));
            */
            return View();
        }

        public ActionResult Book()
        {
            return View(new SearchBookViewModel());
        }

        [HttpPost]
        public ActionResult Book(SearchBookViewModel model)
        {
            ViewBag.result = new ResultViewModel(model.getBook());
            return View(model);
        }
    }
}