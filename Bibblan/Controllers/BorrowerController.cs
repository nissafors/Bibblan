using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
   public class BorrowerController : Controller
   {
      //
      // GET: /Borrower/
      public ActionResult Mypage()
      {
         string ISBN = Request.QueryString.Get("ISBN");
         if(ISBN != null)
         {
            // Renew book
         }
         return View();
      }
   }
}