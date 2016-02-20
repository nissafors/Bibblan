using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Models;
using System.Web.Mvc;

namespace Bibblan.Models
{
    public class SearchAuthorViewModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public Author getAuthor()
        {
            return new Author { FirstName = this.FirstName, LastName = this.LastName };
        }
    }

    public class SearchBookViewModel
    {

        public string ISBN { get; set; }
        public string Title { get; set; }
        public string PublicationYear { get; set; }
        public SelectList Classification { get; set; }
        public int ClassificationId { get; set; }

        public SearchBookViewModel()
        {
        }

    }
}