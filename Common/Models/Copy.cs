using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Models
{
    public class Copy
    {
        public string BarCode { get; set; }
        public string Location { get; set; }
        public Status Status {get; set;}
        public string Library { get; set; }
    }
}
