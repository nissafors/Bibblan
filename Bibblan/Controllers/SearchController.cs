using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Mockup;

namespace Bibblan.Controllers
{
    public class SearchController : Controller
    {


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
            ViewData["cList"] = Services.Mockup.Mockup.cList;
            return View();
        }
	}
}