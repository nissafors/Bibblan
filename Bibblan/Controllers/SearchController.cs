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

        [HttpGet]
        public ActionResult Borrower(string PersonId)
        {
            Borrower borrower = BorrowerServices.GetBorrowerById(PersonId);

            if (borrower != null)
            {
                return View(new BorrowerViewModel(borrower));
            }
            else
            {
                return View(new BorrowerViewModel());
            }
        }

        [HttpPost]
        public ActionResult Borrower(BorrowerViewModel borrower)
        {
            ViewBag.Results = BorrowerServices.GetBorrowers(borrower.ToBorrower());
            return View(borrower);
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