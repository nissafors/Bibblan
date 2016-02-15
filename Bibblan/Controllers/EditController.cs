using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;

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
            SelectList authors = new SelectList((from s in Mockup.authors
                                                select new
                                                {
                                                    Id = s.Id,
                                                    FullName = s.FirstName + " " + s.LastName
                                                }), "Id", "FullName");
            ViewData["author"] = authors;

            SelectList classifications = new SelectList(Mockup.classifications, "Id", "Signum");
            ViewData["classification"] = classifications;

            return View();
        }

        public ActionResult Borrower()
        {
            return View();
        }

        public ActionResult Author()
        {
            return View();
        }
    }
}