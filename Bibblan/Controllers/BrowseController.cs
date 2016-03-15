using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Services.Services;
using Common.Models;
using Bibblan.Helpers;
using Services.Exceptions;

namespace Bibblan.Controllers
{
    public class BrowseController : Controller
    {
        // GET: /Browse/Title
        public ActionResult Title()
        {
            checkAccess();
            try
            {
                List<BookViewModel> bookList = BookServices.GetBooks();
                ViewBag.books = bookList;
            }
            catch (DataAccessException e)
            {
                ViewBag.error = e.Message;
            }
            catch (Exception)
            {
                ViewBag.books = null;
            }
            return View();
        }

        // GET: /Browse/Author
        public ActionResult Author()
        {
            checkAccess();
            try
            {
                List<AuthorViewModel> authorList = AuthorServices.GetAuthors();
                ViewBag.authors = authorList;
            }
            catch(DataAccessException e)
            {
                ViewBag.error = e.Message;
            }
            catch (Exception)
            {
                ViewBag.authors = null;
            }
            return View();
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