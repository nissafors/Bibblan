using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Models;
using System.Web.Mvc;
using Services.Mockup;
using Services.Services;
using System.ComponentModel.DataAnnotations;

namespace Bibblan.Models
{
    public class EditBookViewModel
    {
        private AuthorServices authorServices = new AuthorServices();

        /// <summary>
        /// Create a new empty EditBookViewModel
        /// </summary>
        public EditBookViewModel()
        {
            this.classifications = new SelectList(Mockup.classifications, "Id", "Signum");
            this.authors = new SelectList((from s in authorServices.GetAuthors() select new
            {
                Id = s.Id,
                FullName = s.FirstName + " " + s.LastName
            }), "Id", "FullName");

            Copies = new List<Copy>();
        }

        /// <summary>
        /// Create a new EditBookViewModel from a Book model
        /// </summary>
        /// <param name="book">Populate properties from this Book</param>
        public EditBookViewModel(Book book) : this()
        {
            this.ISBN = book.ISBN;
            this.Title = book.Title;
            this.ClassificationId = book.Classification.Id;
            this.PublicationYear = book.PublicationYear;
            this.PublicationInfo = book.PublicationInfo;
            this.Pages = book.Pages;
            this.Copies = book.Copies;
            this.AuthorIds = book.Authors.Select(author => author.Id).ToList();
        }

        /// <summary>
        /// Convert this viewmodel to a Book object
        /// </summary>
        /// <returns></returns>
        public Book ToBook()
        {
            var book = new Book();
            book.ISBN = this.ISBN;
            book.Title = this.Title;
            book.Classification = ClassificationServices.GetClassification(this.ClassificationId);
            book.PublicationYear = this.PublicationYear;
            book.PublicationInfo = this.PublicationInfo;
            book.Pages = this.Pages;
            book.Copies = this.Copies;
            book.Authors = AuthorServices.GetAuthors(AuthorIds);

            return book;
        }

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

        public List<Copy> Copies { get; set; }

        public SelectList classifications { get; set; }
        public SelectList authors { get; set; }

    }
}