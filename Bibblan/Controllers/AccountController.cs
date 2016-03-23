using Bibblan.Filters;
using Bibblan.Helpers;
using Common.Models;
using Services.Exceptions;
using Services.Services;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
    public class AccountController : Controller
    {

        /// <summary>
        /// Renders the login window if the client does not have a logged in session
        /// Otherwise redirects to Account/AdminPage or Account/UserPage depending on user privligies
        /// GET: Account/Login
        /// </summary>
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
        /// POST : /Account/Login
        /// </summary>
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

        /// <summary>
        /// Clears the session for the client & logs out
        /// GET : /Account/Logout
        /// </summary>
        public ActionResult Logout()
        {
            AccountHelper.ClearSession(Session);
            if (Request.UrlReferrer != null)
                return Redirect(Request.UrlReferrer.ToString());
            else
                return RedirectToAction("Index", "Home");
        }

        /// <summary>
        /// Renders the administrator page if client is Logged in & is an admin
        /// GET : /Account/AdminPage
        /// </summary>
        [RequireLogin(RequiredRole=AccountHelper.Role.Admin)]
        public ActionResult AdminPage()
        {
            if (TempData["error"] != null)
                ViewBag.error = TempData["error"].ToString();

            return View();
        }

        /// <summary>
        /// Renders the user page if client is Logged in & is an normal user
        /// GET : /Account/UserPage
        /// </summary>
        [RequireLogin(RequiredRole = AccountHelper.Role.User, ForceCheck=true)]
        public ActionResult UserPage()
        {
            try
            {
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