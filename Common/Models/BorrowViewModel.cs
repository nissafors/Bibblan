using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Models
{
    public class BorrowViewModel
    {
        public string Title { get; set; }
        public string Barcode { get; set; }
        public string PersonId { get; set; }
        public DateTime BorrowDate { get; set; }
        public DateTime ToBeReturnedDate { get; set; }
        public DateTime ReturnDate { get; set; }
    }
}
