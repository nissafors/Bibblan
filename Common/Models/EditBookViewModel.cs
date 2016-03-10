using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace Common.Models
{
    public class EditBookViewModel
    {
        // Properties
        [Required(ErrorMessage="ISBN krävs")]
        [Display(Name = "ISBN")]
        public string ISBN { get; set; }

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
            /*
            this.Authors = new SelectList((from s in authorServices.GetAuthors() select new
            {
                Id = s.Id,
                FullName = s.FirstName + " " + s.LastName
            }), "Id", "FullName");
            */
            Copies = new List<CopyViewModel>();
        }
    }
}