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
        //
        // GET: /Book/
        public ActionResult Details(string isbn)
        {
            try
            {
                if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                    ViewBag.isAdmin = true;
                else
                    ViewBag.isAdmin = false;

                BookViewModel viewModel = BookServices.GetBookDetails(isbn);
                ViewBag.Book = viewModel;
            }
            catch(DataAccessException e)
            {
                ViewBag.error = e.Message;
            }
            catch(Exception)
            {
                ViewBag.Book = null;
            }
            
            return View();
        }
    }
}