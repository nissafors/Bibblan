using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Common.Models
{
    public class BookAuthor
    {
        public Book Book { get; set; }
        public Author Author { get; set; }

        public int selectedClassificationId { get; set; }
        public IEnumerable<SelectListItem> classifications { get; set; }
    }
}
