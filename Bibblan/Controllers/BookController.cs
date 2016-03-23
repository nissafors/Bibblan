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
    public class BookController : Controller
    {
        /// <summary>
        /// GET: /Book/Details/{isbn}. Show details about a book.
        /// </summary>
        [OutputCache(Duration=60)]
        public ActionResult Details(string isbn = "")
        {
            BookViewModel viewModel = null;
            try
            {
                if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                    ViewBag.isAdmin = true;
                else
                    ViewBag.isAdmin = false;

                viewModel = BookServices.GetBookDetails(isbn);
            }
            catch(DataAccessException e)
            {
                ViewBag.error = e.Message;
            }
            catch(DoesNotExistException e)
            {
                ViewBag.error = e.Message;
            }
            
            return View(viewModel);
        }
    }
}