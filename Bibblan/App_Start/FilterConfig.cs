﻿using System.Web;
using System.Web.Mvc;
using Bibblan.Filters;

namespace Bibblan
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
