﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;
using Services.Services;

namespace Bibblan.Controllers
{
    public class EditController : Controller
    {
        private AuthorServices authorService = new AuthorServices();
        private BorrowerServices borrowerService = new BorrowerServices();

        // GET: Edit
        public ActionResult Index()
        {
            return View();
        }

        // GET: edit/book
        [HttpGet]
        public ActionResult Book(string isbn)
        {
            EditBookViewModel bookInfo = BookServices.GetEditBookViewModel(isbn);

            return View(bookInfo);
        }

        [HttpPost]
        public ActionResult Book(EditBookViewModel bookInfo)
        {
            // TODO:
            // Write bookInfo to db via service

            return View(bookInfo);
        }

        [HttpGet]
        public ActionResult Copy(string barCode)
        {
            /*
            Copy copy = CopyServices.GetCopy(barCode);
            EditCopyViewModel copyInfo;

            if (copy != null)
                copyInfo = new EditCopyViewModel(copy);
            else
                copyInfo = new EditCopyViewModel();
            */
            return View();
        }

        [HttpPost]
        public ActionResult Copy(EditCopyViewModel copyInfo)
        {/*
            Copy copy = copyInfo.ToCopy();
            // TODO:
            // Write copyInfo to db
            */
            /*
            return RedirectToAction("Book", copy.Book);
            */
            return View();
        }

        [HttpGet]
        public ActionResult Borrower(string PersonId)
        {
            /*
            Borrower borrower = BorrowerServices.GetBorrowerById(PersonId);

            if (borrower != null)
            {
                return View(new BorrowerViewModel(borrower));
            }
            else
            {
                return View(new BorrowerViewModel());
            }
            */
            return View();
        }

        [HttpPost]
        public ActionResult Borrower(BorrowerViewModel borrower)
        {
            /*
            if(BorrowerServices.AddBorrower(borrower.ToBorrower()))
            {
                return RedirectToAction("Borrower", "Search");
            }
            else
            {
                return View(borrower);
            }
            */
            return View();
        }

        public ActionResult Delete(string Type, string Id)
        {
            /*
            switch(Type)
            {
                case "Borrower":
                    BorrowerServices.DeleteBorrower(Id);
                    return RedirectToAction("Borrower", "Search");

                case "Author":
                    AuthorServices.DeleteAuthor(Id);
                    return RedirectToAction("Author", "Search");

                case "Book":
                    BookServices.DeleteBook(Id);
                    return RedirectToAction("Book", "Search");

                case "Copy":
                    CopyServices.DeleteCopy(Id);
                    return RedirectToAction("Book", "Edit", CopyServices.GetCopy(Id).Book);

                default:
                    return RedirectToAction("Index", "Home");

            }
            */
            return View();
        }

        public ActionResult Author(int id)
        {
            /*
            //Common.Models.Author author = Services.Mockup.Mockup.authors[0];
            Author author = authorService.GetAuthorById(id);
            if(author != null)
                return View(author);
            */
            return View();
        }
    }
}