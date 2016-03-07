using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
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
            isbn = "0078815037";

            EditBookViewModel bookInfo = BookServices.GetEditBookViewModel(isbn);
            setBookViewLists(bookInfo);

            return View(bookInfo);
        }

        [HttpPost]
        public ActionResult Book(EditBookViewModel bookInfo)
        {
            BookServices.Upsert(bookInfo);
            setBookViewLists(bookInfo);

            return View(bookInfo);
        }
        }

        // Helper for the Book methods
        private void setBookViewLists(EditBookViewModel ebvm)
        {
            ebvm.Copies = CopyServices.getCopyViewModels(ebvm.ISBN);

            var classDic = ClassificationServices.GetClassificationsAsDictionary();
            var authorDic = AuthorServices.GetAuthorsAsDictionary();
            ebvm.Classifications = new SelectList(classDic.OrderBy(x => x.Value), "Key", "Value");
            ebvm.Authors = new SelectList(authorDic.OrderBy(x => x.Value), "Key", "Value");
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
            BorrowerViewModel borrower = null;
            if (PersonId == null)
            {
                borrower = BorrowerServices.GetEmptyBorrower();
            }
            else
            {
                borrower = BorrowerServices.GetBorrower(PersonId);
            }

            return View(borrower);
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