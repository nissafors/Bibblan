using Services.Services;
using System;
using System.Web;

namespace Bibblan.Helpers
{

    /// <summary>
    /// This class is used to help abstract & clean up code that uses the Session indexes like "username" & "role"
    /// </summary>
    public class AccountHelper
    {
        public enum Role { Admin, User };

        private const int LOGIN_MAX_TRIES = 3;
        // delay in seconds until LOGIN_MAX_TRIES is reset
        private const int RETRY_DELAY = 300;

        private const string SESSION_USERNAME_KEY = "username";
        private const string SESSION_ROLE_KEY = "role";
        private const string SESSION_RETRIES_KEY = "retries";
        private const string SESSION_RETRY_DELAY_KEY = "delay";

        public const int MIN_PASSWORD_LENGTH = 4;
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
            if (!IsLoggedIn(session))
                return false;
            // Check against session or database
            if (force)
                return UpdateSessionRole(session) == role;
            else
                return (Role) (session[SESSION_ROLE_KEY]) == role;
        }
        /// <summary>
        /// Does a setup of the session indexes that are used by controllers to check if a Client has logged in
        /// </summary>
        /// <param name="session"></param>
        public static void SetupUserSession(HttpSessionStateBase session, string username, int roleId)
        {
            session[SESSION_USERNAME_KEY] = username;
            session[SESSION_ROLE_KEY] = (Role) roleId;
            session[SESSION_RETRY_DELAY_KEY] = null;
            session[SESSION_RETRIES_KEY] = 0;
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
        public static bool IsLoggedIn(HttpSessionStateBase session)
        {
            return session[SESSION_USERNAME_KEY] != null;
        }

        public static string GetUserName(HttpSessionStateBase session)
        {
            return session[SESSION_USERNAME_KEY].ToString();
        }


        public static bool CanRetryLogin(HttpSessionStateBase session)
        {
            bool returner = false;
            if(session[SESSION_RETRY_DELAY_KEY] == null)
            {
                int tries;
                if (session[SESSION_RETRIES_KEY] != null)
                    tries = (int)session[SESSION_RETRIES_KEY];
                else
                    tries = 0;

                session[SESSION_RETRIES_KEY] = ++tries;
                if (tries >= LOGIN_MAX_TRIES)
                {
                    var serverTime = DateTime.Now.AddSeconds(RETRY_DELAY);
                    session[SESSION_RETRY_DELAY_KEY] = serverTime;
                }
                else
                    returner = true;
            }
            else if( (DateTime) session[SESSION_RETRY_DELAY_KEY] <= DateTime.Now)
            {
                session[SESSION_RETRY_DELAY_KEY] = null;
                session[SESSION_RETRIES_KEY] = 0;
                returner = true;
            }
            return returner;
        }

        public static DateTime GetDelay(HttpSessionStateBase session)
        {
            return (DateTime)session[SESSION_RETRY_DELAY_KEY];
        }

        public static int GetRetriesLeft(HttpSessionStateBase session)
        {
            int tries;
            if (session[SESSION_RETRIES_KEY] == null)
                tries = 0;
            else
                tries = (int)session[SESSION_RETRIES_KEY];
            return LOGIN_MAX_TRIES - tries;
        }

        /// <summary>
        /// Updates the session[roleId] from the database 
        /// </summary>
        /// <param name="session"></param>
        /// <returns></returns>
        private static Role UpdateSessionRole(HttpSessionStateBase session)
        {
            Role role = (Role)(AccountServices.GetRoleId(session[SESSION_USERNAME_KEY].ToString()));
            session[SESSION_ROLE_KEY] = role;
            return role;
        }
    }
}