using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;

namespace Services.Services
{
    public class BookAuthorServices
    {
        /*
        public BookAuthorServices()
        {

        }

        public List<BookAuthor> GetBookAuthors()
        {
            return Mockup.Mockup.bookAuthors;
        }
        
        public List<BookAuthor> GetBookAuthors(Book book)
        {
            List<BookAuthor> bookList = new List<BookAuthor>();

            book.ISBN = book.ISBN == null ? "" : book.ISBN;
            book.Title = book.Title == null ? "" : book.Title;
            book.PublicationYear = book.PublicationYear == null ? "" : book.PublicationYear;

            foreach(BookAuthor bookAuthor in Mockup.Mockup.bookAuthors)
            {
                if(bookAuthor.Book.ISBN.ToLower().Contains(book.ISBN.ToLower()) &&
                    bookAuthor.Book.Title.ToLower().Contains(book.Title.ToLower()) &&
                    bookAuthor.Book.PublicationYear.ToLower().Contains(book.PublicationYear.ToLower()) &&
                    (book.Classification.Id == -1 || bookAuthor.Book.Classification.Id == book.Classification.Id))
                {
                    bookList.Add(bookAuthor);
                } 
            }

            return bookList;
        }

        public List<BookAuthor> GetBookAuthors(Author author)
        {
            List<BookAuthor> bookList = new List<BookAuthor>();

            author.LastName = author.LastName == null ? "" : author.LastName;
            author.FirstName = author.FirstName == null ? "" : author.FirstName;

            foreach (BookAuthor bookAuthor in Mockup.Mockup.bookAuthors)
            {
                if (bookAuthor.Author.FirstName.ToLower().Contains(author.FirstName.ToLower()) &&
                    bookAuthor.Author.LastName.ToLower().Contains(author.LastName.ToLower()))
                {
                    bookList.Add(bookAuthor);
                }
            }

            return bookList;
        }

        public BookAuthor GetBookAuthorByISBN(string isbn)
        {
            return (from bookAuthor in Mockup.Mockup.bookAuthors
                    where bookAuthor.Book.ISBN == isbn
                    select bookAuthor).FirstOrDefault();
        }
        */
    }
}
