using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Models
{
    public class Classification
    {
        public int Id { get; set; }
        public string Signum { get; set; }
        public string Description { get; set; }
        // Todo : Kontrollera relevans för användingsfall
        //public List<Book> Books { get; set; }
    }
}
