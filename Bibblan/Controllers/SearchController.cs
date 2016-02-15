using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;

namespace Bibblan.Controllers
{
    public class SearchController : Controller
    {
        static public List<Classification> cList = new List<Classification>
            {
                new Classification{ Description="Test1", Id=1, Signum="Test1"},
                new Classification{ Description="Test2", Id=2, Signum="Test2"},
                new Classification{ Description="Test3", Id=3, Signum="Test3"}
            };


        //
        // GET: /Search/
        public ActionResult Results()
        {
            return View();
        }

        //
        // GET: /Search/
        public ActionResult Author()
        {
            return View();
        }

        public ActionResult Book()
        {
            ViewData["cList"] = cList;
            return View();
        }
	}
}