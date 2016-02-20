using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Models;
using Services.Services;
namespace Bibblan.Models
{
    public class ResultViewModel
    {
        private List<BookAuthor> bookAuthors;
        public ResultViewModel(Author author)
        {
            bookAuthors = new List<BookAuthor>();
            var bas = new BookAuthorServices();
            var bal = bas.GetBookAuthors(author);
            foreach(var ba in bal)
            {
                bookAuthors.Add(new BookAuthor() { Author = ba.Author, Book = ba.Book });
            }
        }

        public ResultViewModel(Book book)
        {
            bookAuthors = new List<BookAuthor>();
            var bas = new BookAuthorServices();
            var bal = bas.GetBookAuthors(book);
            foreach (var ba in bal)
            {
                bookAuthors.Add(new BookAuthor() { Author = ba.Author, Book = ba.Book });
            }
        }

        public List<BookAuthor> BookAuthors
        {
            get
            {
                return bookAuthors;
            }
        }

        public class BookAuthor
        {
            public Book Book {get; set;}
            public Author Author {get; set;}
        
        }

    }
}