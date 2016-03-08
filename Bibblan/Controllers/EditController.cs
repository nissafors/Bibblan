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

        [HttpPost]
        public ActionResult Copy(CopyViewModel copyInfo)
        {
            CopyServices.Upsert(copyInfo);
            return RedirectToAction("Book", new { copyInfo.ISBN });
        }

        // Helper for the Book ActionResult's.
        private void setBookViewLists(EditBookViewModel ebvm)
        {
            ebvm.Copies = CopyServices.getCopyViewModels(ebvm.ISBN);

            var classDic = ClassificationServices.GetClassificationsAsDictionary();
            var authorDic = AuthorServices.GetAuthorsAsDictionary();
            ebvm.Classifications = new SelectList(classDic.OrderBy(x => x.Value), "Key", "Value");
            ebvm.Authors = new SelectList(authorDic.OrderBy(x => x.Value), "Key", "Value");
        }

        [HttpGet]
        public ActionResult Copy(string isbn, string barcode)
        {
            var cvm = CopyServices.GetCopyViewModel(barcode);
            cvm.ISBN = isbn;

            var statusDic = StatusServices.GetStatusesAsDictionary();
            cvm.Statuses = new SelectList(statusDic.OrderBy(x => x.Value), "Key", "Value");
            cvm.Title = BookServices.GetBookDetails(cvm.ISBN).Title;

            return View(cvm);
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
            if(BorrowerServices.Upsert(borrower))
            {
                // TODO: Handle succesfull or unsuccesfull 
                // TODO: Set history so back button works
            }
            borrower = BorrowerServices.GetBorrower(borrower.PersonId);
            return View(borrower);
        }

        public ActionResult Renew(BorrowViewModel borrowViewModel)
        {
            BorrowServices.Renew(borrowViewModel);
            return Redirect(Request.UrlReferrer.ToString());
        }

        public ActionResult Delete(string Type, string Id)
        {
            switch(Type)
            {
                case "Borrower":
                    BorrowerServices.Delete(Id);
                    return RedirectToAction("Borrower", "Search");

                case "Author":
                    //AuthorServices.DeleteAuthor(Id);
                    return RedirectToAction("Author", "Search");

                case "Book":
                    BookServices.Delete(Id);
                    return RedirectToAction("Book", "Search");

                case "Copy":
                    var isbn = CopyServices.GetCopyViewModel(Id).ISBN;
                    CopyServices.DeleteCopy(Id);
                    return RedirectToAction("Book", new { isbn });

                default:
                    return RedirectToAction("Index", "Home");

            }
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