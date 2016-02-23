using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;
using Services.Services;
using Bibblan.Models;

namespace Bibblan.Controllers
{
    public class EditController : Controller
    {
        private AuthorServices _authorService = new AuthorServices();
        private BorrowerServices _borrowerService = new BorrowerServices();

        // GET: Edit
        public ActionResult Index()
        {
            return View();
        }

        // GET: edit/book
        [HttpGet]
        public ActionResult Book(string isbn)
        {
            EditBookViewModel bookInfo;

            Book book = BookServices.GetBookFromISBN(isbn);

            if (book != null)
                bookInfo = new EditBookViewModel(book);
            else
                bookInfo = new EditBookViewModel();

            return View(bookInfo);
        }

        [HttpPost]
        public ActionResult Book(EditBookViewModel bookInfo)
        {
            Book book = bookInfo.ToBook();
            // TODO:
            // Write bookInfo to db

            return View(bookInfo);
        }

        [HttpGet]
        public ActionResult Copy(string barCode)
        {
            Copy copy = CopyServices.GetCopy(barCode);
            EditCopyViewModel copyInfo;

            if (copy != null)
                copyInfo = new EditCopyViewModel(copy);
            else
                copyInfo = new EditCopyViewModel();

            return View(copyInfo);
        }

        [HttpPost]
        public ActionResult Copy(EditCopyViewModel copyInfo)
        {
            Copy copy = copyInfo.ToCopy();
            // TODO:
            // Write copyInfo to db

            return RedirectToAction("Book", copy.Book);
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
            if(BorrowerServices.AddBorrower(borrower.ToBorrower()))
            {
                return RedirectToAction("Borrower", "Search");
            }
            else
            {
                return View(borrower);
            }
        }

        public ActionResult Delete(string Type, string Id)
        {
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
        }

        public ActionResult Author(int id)
        {
            //Common.Models.Author author = Services.Mockup.Mockup.authors[0];
            Author author = _authorService.GetAuthorById(id);
            if(author != null)
                return View(author);

            return View();
        }
    }
}