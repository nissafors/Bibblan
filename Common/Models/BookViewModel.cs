using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Models
{
    public class BookViewModel
    {
        public string ISBN { get; set; }
        public string Title { get; set; }
        public int SignId { get; set; }
        public string Classification { get; set; }
        public string PublicationYear { get; set; }
        public string PublicationInfo { get; set; }
        public int Pages { get; set; }
        public Dictionary<int, string> Authors { get; set; }

        public BookViewModel()
        {
            this.Authors = new Dictionary<int, string>();
        }
    }
}
