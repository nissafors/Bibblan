using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Bibblan
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                    name: "BookDetails",
                    url: "Book/Details/{isbn}",
                    defaults: new { controller = "Book", action = "Details" }
            );

            routes.MapRoute(
                    name: "EditBorrower",
                    url: "Edit/Borrower/{PersonId}",
                    defaults: new { controller = "Edit", action = "Borrower" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                    name: "EditCopy",
                    url: "Edit/Copy/{barCode}",
                    defaults: new { controller = "Edit", action = "Copy" }
            );
        }
    }
}
