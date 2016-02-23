using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Models;
using System.Web.Mvc;
using Services.Services;
using System.ComponentModel.DataAnnotations;

namespace Bibblan.Models
{
    public class SearchAuthorViewModel
    {
        [Display(Name="Förnamn")]
        public string FirstName { get; set; }
        [Display(Name = "Efternamn")]
        public string LastName { get; set; }

        public Author getAuthor()
        {
            return new Author { FirstName = this.FirstName, LastName = this.LastName };
        }
    }

    public class SearchBookViewModel
    {
        [Display(Name = "ISBN")]
        public string ISBN { get; set; }
        [Display(Name = "Titel")]
        public string Title { get; set; }
        [Display(Name = "Publikationsår")]
        public string PublicationYear { get; set; }
        [Display(Name = "Klassification")]
        public SelectList Classification { get; set; }
        public int ChosenClassification { get; set; }

        public SearchBookViewModel(Book book)
        {
            this.Classification = new SelectList(ClassificationServices.GetClassifications(), "Id", "Signum", book.Classification);
            this.ChosenClassification = book.Classification.Id;
        }

        public SearchBookViewModel()
        {
            this.Classification = new SelectList(ClassificationServices.GetClassifications(), "Id", "Signum");
        }

        public Book getBook()
        {
            return new Book { Title = this.Title, ISBN = this.ISBN, PublicationYear = this.PublicationYear, Classification = ClassificationServices.GetClassification(ChosenClassification)};
        }
    }
}