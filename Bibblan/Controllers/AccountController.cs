using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using Common.Models;
using Services.Services;

namespace Bibblan.Controllers
{
    //[Authorize]
    public class AccountController : Controller
    {

        public ActionResult Login()
        {
            if(AccountHelper.isLoggedIn(this.Session))
            {
                if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                    return RedirectToAction("AdminPage");
                else if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.User))
                    return RedirectToAction("UserPage");
            }
            return View();
        }
        /// <summary>
        /// Takes a AccountViewModel and tries to login
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Login(AccountViewModel model)
        {
            AccountViewModel m = AccountServices.Login(model);
            if(m != null)
            {
                Session["username"] = m.Username;
                // This should not be relied upon when doing actions !!!
                Session["roleId"] = m.RoleId;
                if(AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                        return RedirectToAction("AdminPage");
                else if(AccountHelper.HasAccess(this.Session, AccountHelper.Role.User))
                        return RedirectToAction("UserPage");
            }
            ViewBag.userNotFound = true;
            return View();
        }


        public ActionResult Logout()
        {
            Session.Clear();
            Session.Abandon();
            if (Request.UrlReferrer != null)
                return Redirect(Request.UrlReferrer.ToString());
            else
                return RedirectToAction("Index", "Home");
        }

        public ActionResult AdminPage()
        {
            int role = Convert.ToInt32(Session["roleId"]);
            if(Session["roleId"] != null && role == 0)
            {
                return View();
            }
            return RedirectToAction("Login");
        }

        public ActionResult UserPage()
        {
            // Do not rely on session for roleId, because we list User details (Loans)
            // Instead check Database if we still have the right access
            if (!AccountHelper.isLoggedIn(this.Session))
                return RedirectToAction("Login");
            else if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.User))
                return View();
            return RedirectToAction("Login");
        }
    }
}