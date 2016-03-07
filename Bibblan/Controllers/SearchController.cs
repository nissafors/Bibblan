﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Services;
using System.Diagnostics;

namespace Bibblan.Controllers
{
    public class SearchController : Controller
    {

        // Show borrower
        [HttpGet]
        public ActionResult Borrower(string personId)
        {
            BorrowerViewModel model = BorrowerServices.GetBorrower(personId);
            return model == null ? View(new BorrowerViewModel()) : View(model);
        }

        // Update or add borrower
        [HttpPost]
        public ActionResult Borrower(BorrowerViewModel model)
        {
            return View(model);
            
            /*
            //List<Borrower> borrowerList = BorrowerServices.GetBorrowers(borrower.ToBorrower());
            //List<BorrowerViewModel> viewModelList = new List<BorrowerViewModel>();
            //
            //foreach(Borrower borrowerItem in borrowerList)
            //{
            //    viewModelList.Add(new BorrowerViewModel(borrowerItem));
            //}

            ViewBag.Results = BorrowerServices.GetBorrowers(borrower);

            return View(borrower);
            */
        }
        

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
        /*
        public ActionResult Author(SearchAuthorViewModel model)
        {
            if (ViewHelper.isQueryMapped(model, Request.QueryString))
                ViewBag.result = new ResultViewModel(model.getAuthor());
            else
                ViewBag.result = null;

            return View(model);
        }
        */
        public ActionResult Book(string search)
        {
            if (search == null)
                ViewBag.result = null;
            else
            {
                List<BookViewModel> model;
                model = BookServices.SearchBooks(search);
                ViewBag.result = model;
            }

            return View();
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