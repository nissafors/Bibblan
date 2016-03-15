using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            if (TempData["error"] != null)
                ViewBag.error = TempData["error"];

            return View();
        }
    }
}