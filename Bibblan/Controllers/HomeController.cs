using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
    public class HomeController : Controller
    {
        /// <summary>
        /// GET: /Home/Index. The home page of the site.
        /// </summary>
        public ActionResult Index()
        {
            if (TempData["error"] != null)
                ViewBag.error = TempData["error"];

            return View();
        }

        /// <summary>
        /// GET: /Home/Widget. Demopage for the searchwidget.
        /// </summary>
        /// <returns></returns>
        public ActionResult Widget()
        {
            return View();
        }
    }
}