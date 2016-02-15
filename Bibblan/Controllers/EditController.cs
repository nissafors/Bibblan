using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;

namespace Bibblan.Controllers
{
    public class EditController : Controller
    {
        // GET: Edit
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Book()
        {
            ViewData["author"] = new SelectList(Services.Mockup.Mockup.authors);
            ViewData["classification"] = new SelectList(Services.Mockup.Mockup.classifications);

            return View();
        }

        public ActionResult Borrower()
        {
            return View();
        }

        public ActionResult Author()
        {
            Common.Models.Author author = Services.Mockup.Mockup.authors[0];
            return View(author);
        }
    }
}