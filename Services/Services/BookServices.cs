using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Services.Services;

namespace Services.Services
{
    public class BookServices
    {
        public List<Book> GetBooks()
        {
            return Mockup.Mockup.books;
        }

        public Book GetBookFromCopy(Copy copy)
        {
            foreach(var book in Mockup.Mockup.books)
            {
                if (book.Copies.Contains(copy))
                    return book;
            }
            return null;
        }

        public Book GetBookFromISBN(string ISBN)
        {
            foreach (var book in Mockup.Mockup.books)
            {
                if (book.ISBN == ISBN)
                    return book;
            }
            return null;
        }

        public bool DeleteBook(string isbn)
        {
            return false;
        }

        public static List<Book> GetBooksByAuthor(Author author)
        {
            if(Mockup.Mockup.authors[0].Books == null)
            {
                Mockup.Mockup.authors[0].Books = new List<Book> { Mockup.Mockup.books[0] };
                Mockup.Mockup.authors[1].Books = new List<Book> { Mockup.Mockup.books[1], Mockup.Mockup.books[2] };
                Mockup.Mockup.authors[2].Books = new List<Book> { Mockup.Mockup.books[2] };
            }
            string firstName =  author.FirstName == null ? "" : author.FirstName.ToLower();
            string lastName = author.LastName == null ? "" : author.LastName.ToLower();
            var books = new List<Book>();
                foreach(var au in Mockup.Mockup.authors)
                {
                    string fname = au.FirstName.ToLower();
                    string lname = au.LastName.ToLower();

                    if (fname.Contains(firstName) && lname.Contains(lastName))
                    {
                        foreach(var b in au.Books)
                        {
                            if (!books.Contains(b))
                                books.Add(b);
                        }
                    }
                        //books.AddRange(au.Books);
                }
                return books;
            }
    }
}
