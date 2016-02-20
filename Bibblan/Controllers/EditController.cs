using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;
using Services.Services;
using Bibblan.Models;
using Bibblan.ViewModels;

namespace Bibblan.Controllers
{
    public class EditController : Controller
    {
        private AuthorServices _authorService = new AuthorServices();
        private CopyServices _copyService = new CopyServices();
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
            //isbn = "666-6";
            EditBookViewModel bookInfo;

            BookServices bc = new BookServices();
            Book book = bc.GetBookFromISBN(isbn);

            if (book != null)
                bookInfo = new EditBookViewModel(book);
            else
                bookInfo = new EditBookViewModel();

            return View(bookInfo);
        }

        [HttpPost]
        public ActionResult Book(EditBookViewModel bookInfo)
                                                {
            // TODO:
            // Write bookInfo to db

            return View(bookInfo);
        }

        public ActionResult Copy(string barCode)
        {
            //CopyServices cs = new CopyServices();
            //Copy copy = cs.GetCopiesFrom
            //
            //EditCopyViewModel copyInfo = new EditCopyViewModel();

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
            BorrowerServices.AddBorrower(borrower.ToBorrower());
            return View(borrower);
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
                    return RedirectToAction("Book", "Edit", _copyService.GetCopy(Id).Book);

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