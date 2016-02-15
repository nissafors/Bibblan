using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Models
{
    public class Loan
    {
        public string BarCode { get; set; }
        public string BorrowDate { get; set; }
        public string ToBeReturnedDate { get; set; }
        public string ReturnDate { get; set; }
    }
}
