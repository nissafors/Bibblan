using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Models
{
    public class CopyViewModel
    {
        public string BarCode { get; set; }
        public string Location { get; set; }
        public int StatusId { get; set; }
        public string ISBN { get; set; }
        public string Library { get; set; }
    }
}
