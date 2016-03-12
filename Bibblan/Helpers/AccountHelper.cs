using Common.Models;
using Services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bibblan.Helpers
{

    /// <summary>
    /// This class is used to help abstract & clean up code that uses the Session indexes like "username" & "role"
    /// </summary>
    public class AccountHelper
    {
        public enum Role { Admin, User };
        /// <summary>
        /// Returns a true if the user has the the given role, if force is true it checks the role against the database instead
        /// </summary>
        /// <param name="session"></param>
        /// <param name="role"></param>
        /// <param name="force"></param>
        /// <returns></returns>
        public static bool HasAccess(HttpSessionStateBase session, Role role, bool force = false)
        {
            // We are not logged in
            if (!isLoggedIn(session))
                return false;
            // Check against session or database
            if (force)
                return UpdateSessionRole(session) == role;
            else
                return (Role) (session["role"]) == role;
        }
        /// <summary>
        /// Does a setup of the session indexes that are used by controllers to check if a Client has logged in
        /// </summary>
        /// <param name="session"></param>
        public static void SetupUserSession(HttpSessionStateBase session, string username, int roleId)
        {
            session["username"] = username;
            session["role"] = (Role) roleId;
        }

        /// <summary>
        /// Clears the session of all indexes & variables
        /// </summary>
        /// <param name="session"></param>
        public static void ClearSession(HttpSessionStateBase session)
        {
            session.Clear();
            session.Abandon();
        }

        /// <summary>
        /// Checks if the session is set as logged in
        /// </summary>
        /// <param name="session"></param>
        /// <returns></returns>
        public static bool isLoggedIn(HttpSessionStateBase session)
        {
            return session["username"] != null;
        }

        /// <summary>
        /// Updates the session[roleId] from the database 
        /// </summary>
        /// <param name="session"></param>
        /// <returns></returns>
        private static Role UpdateSessionRole(HttpSessionStateBase session)
        {
            Role role = (Role)(AccountServices.getRoleId(session["username"].ToString()));
            session["role"] = role;
            return role;
        }
    }
}