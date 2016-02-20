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

        static public bool DeleteBook(string ISBN)
        {
            return false;
        }
    }
}
