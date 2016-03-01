using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;
using Services.Services;
using System.Diagnostics;

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

        //[HttpGet]
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
        /*
        [HttpPost]
        public ActionResult Borrower(BorrowerViewModel borrower)
        {
            //List<Borrower> borrowerList = BorrowerServices.GetBorrowers(borrower.ToBorrower());
            //List<BorrowerViewModel> viewModelList = new List<BorrowerViewModel>();
            //
            //foreach(Borrower borrowerItem in borrowerList)
            //{
            //    viewModelList.Add(new BorrowerViewModel(borrowerItem));
            //}

            ViewBag.Results = BorrowerServices.GetBorrowers(borrower);

            return View(borrower);
        }
        */

        //
        // POST: /Search/
        /*
        [HttpPost]
        public ActionResult Author(SearchAuthorViewModel model)
        {
            ViewBag.result = new ResultViewModel(model.getAuthor());
            return View(model);
        }
        */
        //
        // GET: /Search/
        public ActionResult Author(SearchAuthorViewModel model)
        {
            if (ViewHelper.isQueryMapped(model, Request.QueryString))
                ViewBag.result = new ResultViewModel(model.getAuthor());
            else
                ViewBag.result = null;

            return View(model);
        }

        public ActionResult Book(SearchBookViewModel model)
        {
            if (ViewHelper.isQueryMapped(model, Request.QueryString, model.GetType().GetProperty("Classification")))
                ViewBag.result = new ResultViewModel(model.getBook());
            else
                ViewBag.result = null;

            return View(model);
        
        }
        /*
        [HttpPost]
        public ActionResult Book(SearchBookViewModel model)
        {
            ViewBag.result = new ResultViewModel(model.getBook());
            return View(model);
        }
        */
    }
}