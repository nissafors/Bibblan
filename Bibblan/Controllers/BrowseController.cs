﻿using Bibblan.Helpers;
using Common.Models;
using Services.Exceptions;
using Services.Services;
using System.Collections.Generic;
using System.Web.Mvc;


namespace Bibblan.Controllers
{
    public class BrowseController : Controller
    {
        /// <summary>
        /// GET: /Browse/Title. List all books in the database.
        /// </summary>
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

            return View();
        }

        /// <summary>
        /// GET: /Browse/Author. List all authors in the database.
        /// </summary>
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

            return View();
        }

        /// <summary>
        /// Do  permission checking for the user.
        /// </summary>
        /// <remarks>Session cannot be checked in has Constructor since it is built later in the lifecycle of the
        /// controller instance.</remarks>
        private void checkAccess()
        {
            if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                ViewBag.isAdmin = true;
            else
                ViewBag.isAdmin = false;
        }
	}
}