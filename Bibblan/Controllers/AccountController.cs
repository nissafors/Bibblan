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
using Bibblan.Helpers;
using Bibblan.Filters;
using Services.Exceptions;

namespace Bibblan.Controllers
{
    public class AccountController : Controller
    {

        public ActionResult Login()
        {
            if(AccountHelper.IsLoggedIn(this.Session))
            {
                if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                    return RedirectToAction("AdminPage");
                else if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.User, true))
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
            AccountViewModel m;
            string errorMessage = null;
            try
            {
                m = AccountServices.Login(model);
            }
            catch(DoesNotExistException e)
            {
                errorMessage = e.Message;
                m = null;
            }

            if(AccountHelper.GetRetriesLeft(Session) > 0 &&  m != null)
            {
                // Setups the session indexes
                AccountHelper.SetupUserSession(Session, m.Username, m.RoleId);

                if(AccountHelper.HasAccess(Session, AccountHelper.Role.Admin))
                        return RedirectToAction("AdminPage");
                else if(AccountHelper.HasAccess(Session, AccountHelper.Role.User))
                        return RedirectToAction("UserPage");
            }
            else if(AccountHelper.CanRetryLogin(Session))
            {
                
                errorMessage += AccountHelper.GetRetriesLeft(Session).ToString() + " försök kvar\n";
            }
            else
            {
                errorMessage = "Du har överskridit max antal inloggningsförsök\n";
                errorMessage += "Vänligen vänta tills " + AccountHelper.GetDelay(Session).ToShortTimeString() + "\n";
            }


            ViewBag.loginError = errorMessage;
            return View();
        }


        public ActionResult Logout()
        {
            AccountHelper.ClearSession(Session);
            if (Request.UrlReferrer != null)
                return Redirect(Request.UrlReferrer.ToString());
            else
                return RedirectToAction("Index", "Home");
        }

        [RequireLogin(RequiredRole=AccountHelper.Role.Admin)]
        public ActionResult AdminPage()
        {
            if (TempData["error"] != null)
                ViewBag.error = TempData["error"].ToString();

            return View();
        }

        [RequireLogin(RequiredRole = AccountHelper.Role.User, ForceCheck=true)]
        public ActionResult UserPage()
        {
            try
            {
                //BorrowerViewModel viewModel = BorrowerServices.GetBorrower(AccountHelper.GetUserName(this.Session));
                ViewBag.Borrows = BorrowServices.GetBorrows(AccountHelper.GetUserName(this.Session), true);
            }
            catch(DataAccessException e)
            {
                ViewBag.error = e.Message;
            }

            return View();
        }
    }
}