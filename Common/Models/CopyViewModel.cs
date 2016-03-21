using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace Common.Models
{
    // Used by:
    // * /Edit/Copy (as main viewmodel)
    public class CopyViewModel
    {
        [Required(ErrorMessage="En streckkod krävs")]
        [Display(Name = "Streckkod")]
        public string BarCode { get; set; }

        [Display(Name = "Plats")]
        public string Location { get; set; }

        [Display(Name = "Status")]
        public int StatusId { get; set; }

        [Display(Name = "Bibliotek")]
        public string Library { get; set; }

        public string ISBN { get; set; }

        public SelectList Statuses { get; set; }
        public string Title { get; set; }
        public bool Update { get; set; }
    }
}
