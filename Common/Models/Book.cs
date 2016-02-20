using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Models
{
    public class Book
    {
        public string ISBN { get; set; }
        public string Title { get; set; }
        public Classification Classification { get; set; }
        public string PublicationYear { get; set; }
        public string PublicationInfo { get; set; }
        public int Pages { get; set; }
        public List<Copy> Copies { get; set; }
        public List<Author> Authors { get; set; }
    }
}
