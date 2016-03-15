using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Services.Services;
using Common.Models;

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
                BookViewModel viewModel = BookServices.GetBookDetails(isbn);
                ViewBag.Book = viewModel;
            }
            catch(Exception)
            {
                ViewBag.Book = null;
            }
            
            return View();
        }
    }
}