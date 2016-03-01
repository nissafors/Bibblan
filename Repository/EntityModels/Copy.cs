using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.EntityModels
{
    public class Copy
    {
        public string Barcode { get; set; }
        public string Location { get; set; }
        public int StatusId {get; set;}
        public string ISBN { get; set; }
        public string Library { get; set; }

        //public static bool GetCopies(out List<Copy> copies, string isbn)
        //{
        //
        //}

        //private static bool getCopies(out List<Copy> copies, )
    }
}
