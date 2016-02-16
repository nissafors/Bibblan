using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
    public class BookController : Controller
    {
        //
        // GET: /Book/
        public ActionResult Details(string isbn)
        {
            return View();
        }
	}
}