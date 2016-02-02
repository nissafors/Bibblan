using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Bibblan.Models;

namespace Bibblan.Controllers
{
   public class BorrowerController : Controller
   {
      //
      // GET: /Borrower/
      public ActionResult Mypage(int ISBN = 0)
      {
         return View();
      }
   }
}