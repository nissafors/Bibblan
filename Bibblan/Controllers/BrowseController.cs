using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
    public class BrowseController : Controller
    {
        //
        // GET: /Browse/
        public ActionResult Title()
        {
            return View();
        }

        public ActionResult Author()
        {
            return View();
        }
	}
}