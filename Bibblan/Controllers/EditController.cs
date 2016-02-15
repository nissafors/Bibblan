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
            List<string> authors = new List<string>();
            authors.Add("Pelle Person");
            authors.Add("Sten Sture d.y.");
            ViewData["author"] = new SelectList(authors);

            List<string> classifications = new List<string>();
            classifications.Add("Hce");
            classifications.Add("Que");
            ViewData["classification"] = new SelectList(classifications);

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