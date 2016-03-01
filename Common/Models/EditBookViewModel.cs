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
        [Required]
        [Display(Name = "ISBN")]
        public string ISBN { get; set; }

        [Required]
        [Display(Name = "Titel")]
        public string Title { get; set; }

        [Required]
        [Display(Name = "Klassifikation")]
        public int ClassificationId { get; set; }

        [Required]
        [Display(Name = "Publiceringsår")]
        public string PublicationYear { get; set; }

        [Required]
        [Display(Name = "Publiceringsinformation")]
        public string PublicationInfo { get; set; }

        [Required]
        [Display(Name = "Sidantal")]
        public int Pages { get; set; }

        [Required]
        [Display(Name = "Författare")]
        public List<int> AuthorIds { get; set; }

        public List<CopyViewModel> Copies { get; set; }

        [Display(Name = "Klassifikation")]
        public SelectList Classifications { get; set; }

        [Display(Name = "Författare")]
        public SelectList Authors { get; set; }

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