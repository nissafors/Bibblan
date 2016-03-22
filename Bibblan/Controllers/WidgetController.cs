using Common.Models;
using Services.Exceptions;
using Services.Services;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Bibblan.Controllers
{
    public class WidgetController : ApiController
    {
        /// <summary>
        /// GET: api/Widget. Redirect to Get("").
        /// </summary>
        public HttpResponseMessage Get()
        {
            return Get("");
        }

        /// <summary>
        /// GET: api/Widget/{title}. Return search results. Empty string gives zero length result.
        /// </summary>
        public HttpResponseMessage Get(string title)
        {
            var bvms = new List<BookViewModel>();
            var results = new List<KeyValuePair<string, List<string>>>(); // Title, authors

            if (title != "")
            {
                try
                {
                    bvms = BookServices.SearchBooks(title);
                    foreach (var bvm in bvms)
                    {
                        results.Add(new KeyValuePair<string, List<string>>(bvm.Title, bvm.Authors.Select(i => i.Value).ToList()));
                    }
                }
                catch (DataAccessException)
                {
                    results.Add(new KeyValuePair<string, List<string>>("Får inte kontakt med bibblan just nu. Försök igen senare.", null));
                }
            }

            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, results);
            response.ReasonPhrase = "OK";

            return response;
        }
    }
}
