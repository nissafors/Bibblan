using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Bibblan.Helpers;
namespace Bibblan.Filters
{
    /// <summary>
    /// This filter can be added to redirect the client to the login page if Session privilgies for a specific view is not set
    /// </summary>
    public class RequireLogin : ActionFilterAttribute, IActionFilter
    {
        public AccountHelper.Role RequiredRole {get; set;}
        public bool ForceCheck { get; set; }

        /// <summary>
        /// Uses the AccountHelper static functions to se if client has priviligies, otherwise redirect to referrer or Login page
        /// </summary>
        /// <param name="context"></param>
        void IActionFilter.OnActionExecuting(ActionExecutingContext context)
        {
            var session = context.HttpContext.Session;
            if(!AccountHelper.HasAccess(session, RequiredRole, ForceCheck))
            {
                var url = "~/Account/Login";
                context.Result = new RedirectResult(url);
            }

            this.OnActionExecuting(context);
        }
    }
}