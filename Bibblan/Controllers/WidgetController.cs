using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Bibblan.Controllers
{
    public class WidgetController : ApiController
    {
        // GET: api/Widget
        public HttpResponseMessage Get()
        {
            HttpResponseMessage response = Request.CreateResponse(
                HttpStatusCode.OK,
                new List<string>()
            );

            response.ReasonPhrase = "OK";

            return response;
        }

        // GET: api/Widget/{title}
        public HttpResponseMessage Get(string title)
        {
            HttpResponseMessage response = Request.CreateResponse(
                HttpStatusCode.OK,
                new List<string>()
            );

            response.ReasonPhrase = "OK";

            return response;
        }
    }
}
