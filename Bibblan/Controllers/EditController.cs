using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;
using Services.Services;
using Bibblan.ViewModels;

namespace Bibblan.Controllers
{
    public class EditController : Controller
    {
        private AuthorServices _authorService = new AuthorServices();
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

        public ActionResult Borrower()
        {
            return View();
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