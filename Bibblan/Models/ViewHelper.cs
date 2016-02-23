using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Reflection;
using System.Web;

namespace Bibblan.Models
{
    public class ViewHelper
    {
        /// <summary>
        /// Check if a querystring can be correctly mapped to an object
        /// This is usefull when using a form that makes a get-request to check if data has been submitted
        /// </summary>
        /// <param name="instanceToMap"></param>
        /// <param name="queryString"></param>
        /// <param name ="ignore"></param>
        /// <returns></returns>
        public static bool isQueryMapped(object instanceToMap, NameValueCollection queryString, PropertyInfo[] ignoreProperties = null)
        {
            var properties = instanceToMap.GetType().GetProperties();
            var IgnoreLength = ignoreProperties == null ? 0 : ignoreProperties.Length;
            if (queryString.Count != properties.Length - IgnoreLength)
                return false;

            foreach(var property in properties)
            {
                if (ignoreProperties != null && !ignoreProperties.Contains(property) && queryString[property.Name] == null)
                    return false;
            }

            return true;
        }

        public static bool isQueryMapped(object instanceToMap, NameValueCollection queryString, PropertyInfo ignoreProperty)
        {
            return isQueryMapped(instanceToMap, queryString, new [] {ignoreProperty});
        }
    }
}