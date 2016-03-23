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
    public class WidgetResponseRow
    {
        public WidgetResponseRow(string isbn, string title, List<string> authors)
        {
            ISBN = isbn;
            Title = title;
            Authors = authors;
        }

        public string ISBN { get; set; }
        public string Title { get; set; }
        public List<string> Authors { get; set; }
    }

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
            //var results = new List<KeyValuePair<string, List<string>>>(); // Title, authors
            var results = new List<WidgetResponseRow>();

            if (title != "")
            {
                try
                {
                    bvms = BookServices.SearchBooks(title);
                    foreach (var bvm in bvms)
                    {
                        results.Add(new WidgetResponseRow(bvm.ISBN, bvm.Title, bvm.Authors.Select(i => i.Value).ToList()));
                    }
                }
                catch (DataAccessException)
                {
                    var error = new HttpError("Data access error.");
                    return Request.CreateResponse(HttpStatusCode.InternalServerError, error);
                }
            }

            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, results);
            response.ReasonPhrase = "OK";

            return response;
        }
    }
}
