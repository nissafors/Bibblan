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
                    name: "DeleteObject",
                    url: "Edit/Delete/{Type}/{Id}",
                    defaults: new { controller = "Edit", action = "Delete" }
            );

            routes.MapRoute(
                    name: "EditBorrower",
                    url: "Edit/Borrower/{PersonId}",
                    defaults: new { controller = "Edit", action = "Borrower" }
            );

            routes.MapRoute(
                    name: "EditCopy",
                    url: "Edit/Copy/{isbn}/{barcode}",
                    defaults: new { controller = "Edit", action = "Copy", barcode = UrlParameter.Optional }
            );

            routes.MapRoute(
                    name: "EditBook",
                    url: "Edit/Book/{isbn}",
                    defaults: new { controller = "Edit", action = "Book" }
            );

            routes.MapRoute(
                    name: "EditAuthor",
                    url: "Edit/Author/{authorid}",
                    defaults: new { controller = "Edit", action = "Author" }
            );

            routes.MapRoute(
                    name: "EditAccount",
                    url: "Edit/Account/{username}",
                    defaults: new { controller = "Edit", action = "Account", username = UrlParameter.Optional }
            );

            routes.MapRoute(
                    name: "ChangePassword",
                    url: "Edit/ChangePassword/{Username}",
                    defaults: new { controller = "Edit", action = "Password" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
