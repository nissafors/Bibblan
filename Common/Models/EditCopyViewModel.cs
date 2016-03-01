using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Models;
using System.Web.Mvc;

namespace Bibblan.Models
{
    public class EditCopyViewModel
    {
        public string BarCode { get; set; }
        public string Location { get; set; }
        public int StatusId { get; set; }
        public string Library { get; set; }
        public string ISBN { get; set; }

        public SelectList Statuses { get; set; }
    }
}