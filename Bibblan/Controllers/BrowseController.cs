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
        //
        // GET: /Browse/Title
        public ActionResult Title()
        {
            //ViewBag.books = BookServices.GetBooks();
            return View();
        }

        //
        // GET: /Browse/Author
        public ActionResult Author()
        {
            //ViewBag.authors = _authorServices.GetAuthors();
            return View();
        }
	}
}