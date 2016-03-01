using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Models;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace Bibblan.Models
{
    public struct BookCopy
    {
        public string barCode;
        public string location;
        public int statusId;
        public string isbn;
        public string library;
    }

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

        public List<BookCopy> Copies { get; set; }

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
            this.classifications = new SelectList(Mockup.classifications, "Id", "Signum");
            this.authors = new SelectList((from s in authorServices.GetAuthors() select new
            {
                Id = s.Id,
                FullName = s.FirstName + " " + s.LastName
            }), "Id", "FullName");
            */
            Copies = new List<BookCopy>();
        }

        public EditBookViewModel(Dictionary<int, string> classifications, Dictionary<int, string> authors)
        {
            this.Classifications = new SelectList(classifications.OrderBy(x => x.Value), "Key", "Value");
            this.Authors = new SelectList(authors.OrderBy(x => x.Value), "Key", "Value");
        }
    }
}