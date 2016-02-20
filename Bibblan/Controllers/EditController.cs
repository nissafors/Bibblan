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
            isbn = "666-6";
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
            // Fill authors list
            // Write bookInfo to db

            return View(bookInfo);
        }

        public ActionResult Copy(Copy copy = null)
        {
            IEnumerable<SelectListItem> statuses = new SelectList(Mockup.statuses, "Id", "StatusName");
            ViewData["statuses"] = statuses;

            return View(copy);
        }

        [HttpGet]
        public ActionResult Borrower(string PersonId)
        {
            if(PersonId != null)
            {
                return View(new BorrowerViewModel(PersonId));
            }

            return View(new BorrowerViewModel());
        }

        [HttpPost]
        public ActionResult Borrower(BorrowerViewModel borrower)
        {
            // Services.addBorrower(borrower.ToBorrowerModel())
            return View(borrower);
        }

        public ActionResult Delete(string Type, string Id)
        {
            switch(Type)
        {
                case "Borrower":
                    _borrowerService.DeleteBorrower(Id);
                    return RedirectToAction("Borrower", "Search");

                case "Author":
                    // Services.deleteAuthor(Id);
                    return RedirectToAction("Author", "Search");

                case "Book":
                    // Services.deleteBorrower(Id);
                    return RedirectToAction("Book", "Search");

                case "Copy":
                    // Services.deleteBorrower(Id);
                    // TODO: Fix link to correct book
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