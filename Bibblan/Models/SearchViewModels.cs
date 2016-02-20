using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Models;
using System.Web.Mvc;
using Services.Services;

namespace Bibblan.Models
{
    public class SearchAuthorViewModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public Author getAuthor()
        {
            return new Author { FirstName = this.FirstName, LastName = this.LastName };
        }
    }

    public class SearchBookViewModel
    {

        public string ISBN { get; set; }
        public string Title { get; set; }
        public string PublicationYear { get; set; }
        public SelectList Classification { get; set; }
        public int ChosenClassification { get; set; }

        public SearchBookViewModel(Book book)
        {
            this.Classification = new SelectList(ClassificationServices.getClassifications(), "Id", "Signum", book.Classification);
            this.ChosenClassification = book.Classification.Id;
        }

        public SearchBookViewModel()
        {
            this.Classification = new SelectList(Services.Mockup.Mockup.classifications, "Id", "Signum");
        }

        public Book getBook()
        {
            return new Book { Title = this.Title, ISBN = this.ISBN, PublicationYear = this.PublicationYear, Classification = ClassificationServices.getClassification(ChosenClassification)};
        }
    }
}