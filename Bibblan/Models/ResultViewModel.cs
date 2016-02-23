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
        private List<Book> books;

        public ResultViewModel(Author author)
        {
            books = BookServices.GetBooks(author);
        }

        public ResultViewModel(Book book)
        {
            books = BookServices.GetBooks(book);
        }

        public List<Book> Books
        {
            get
            {
                return books;
            }
        }

    }
}