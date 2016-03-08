using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Services.Services;
using Common.Models;

namespace Bibblan.Controllers
{
    public class BrowseController : Controller
    {
        // GET: /Browse/Title
        public ActionResult Title()
        {
            checkAccess();
            List<BookViewModel> bookList = BookServices.GetBooks();
            ViewBag.books = bookList;
            return View();
        }

        //
        // GET: /Browse/Author
        public ActionResult Author()
        {
            checkAccess();
            var model = new BrowserAuthorViewModel();
            model.Authors = AuthorServices.GetAuthors();
            return View(model);
        }
        /// <summary>
        /// Session cannot be checked in has Constructor since it is built later in the lifecycle of the controller instance
        /// </summary>
        private void checkAccess()
        {
            if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                ViewBag.isAdmin = true;
            else
                ViewBag.isAdmin = false;
        }
	}
}