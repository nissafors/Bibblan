using Common.Models;
using Services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
    public class AccountHelper
    {
        public enum Role { Admin, User };
        /// <summary>
        /// Returns if the session has access to a given role
        /// </summary>
        /// <param name="session"></param>
        /// <param name="role"></param>
        /// <returns></returns>
        public static bool HasAccess(HttpSessionStateBase session, Role role)
        {
            if (session["username"] == null)
                return false;

            string username = session["username"].ToString();
            return UpdateSessionRole(session) == role;
        }

        /// <summary>
        /// Updates the session[roleId] from the database 
        /// </summary>
        /// <param name="session"></param>
        /// <returns></returns>
        private static Role UpdateSessionRole(HttpSessionStateBase session)
        {
            int role = AccountServices.getRoleId(session["username"].ToString());
            session["role"] = role;
            return (Role) role;
        }

        public static bool isLoggedIn(HttpSessionStateBase session)
        {
            return session["username"] != null;
        }

    }
}