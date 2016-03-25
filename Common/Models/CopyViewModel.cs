using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Common.Models
{
    /// <summary>
    /// View model for /Edit/Copy.</summary>
    public class CopyViewModel
    {
        [Required(ErrorMessage="En streckkod krävs")]
        [MaxLength(20, ErrorMessage="Max 20 tecken")]
        [Display(Name = "Streckkod")]
        public string BarCode { get; set; }

        [Display(Name = "Plats")]
        [MaxLength(50, ErrorMessage="Max 50 tecken")]
        public string Location { get; set; }

        [Display(Name = "Status")]
        public int StatusId { get; set; }

        [Display(Name = "Bibliotek")]
        [MaxLength(50, ErrorMessage = "Max 50 tecken")]
        public string Library { get; set; }

        public string ISBN { get; set; }

        public SelectList Statuses { get; set; }
        public string Title { get; set; }
        public bool Update { get; set; }
    }
}
