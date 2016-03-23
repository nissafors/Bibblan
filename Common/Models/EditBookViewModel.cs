using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Common.Models
{
    /// <summary>
    /// View model for /Edit/Book.</summary>
    public class EditBookViewModel
    {
        // Properties
        [Required(ErrorMessage="ISBN krävs")]
        [Display(Name = "ISBN")]
        public string ISBN { get; set; }

        [Required(ErrorMessage = "Titel krävs")]
        [Display(Name = "Titel")]
        public string Title { get; set; }

        [Display(Name = "Klassifikation")]
        public int ClassificationId { get; set; }

        [Display(Name = "Publiceringsår")]
        public string PublicationYear { get; set; }

        [Display(Name = "Publiceringsinformation")]
        public string PublicationInfo { get; set; }

        [Display(Name = "Sidantal")]
        public int Pages { get; set; }

        [Required(ErrorMessage="Minst en författare måste väljas")]
        [Display(Name = "Författare")]
        public List<int> AuthorIds { get; set; }

        public List<CopyViewModel> Copies { get; set; }

        [Display(Name = "Klassifikation")]
        public SelectList Classifications { get; set; }

        [Display(Name = "Författare")]
        public SelectList Authors { get; set; }

        public bool Update { get; set; }

        /// <summary>
        /// Create a new empty EditBookViewModel
        /// </summary>
        public EditBookViewModel()
        {
            Copies = new List<CopyViewModel>();
        }
    }
}