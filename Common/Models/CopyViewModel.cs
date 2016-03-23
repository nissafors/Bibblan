﻿using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Common.Models
{
    /// <summary>
    /// View model for /Edit/Copy.</summary>
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
