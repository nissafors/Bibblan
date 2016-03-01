using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;

namespace Services.Services
{
    public class BookServices
    {
        public static EditBookViewModel GetEditBookViewModel(string isbn)
        {


            EditBookViewModel ebvm = new EditBookViewModel();

            return ebvm;
        }

        //public List<Book> GetBooks()
        //{
        //    return Mockup.Mockup.books;
        //}

        //public 

        //public Book GetBookFromCopy(Copy copy)
        //{
        //    foreach(var book in Mockup.Mockup.books)
        //    {
        //        if (book.Copies.Contains(copy))
        //            return book;
        //    }
        //    return null;
        //}

        //public static Book GetBookFromISBN(string ISBN)
        //{
        //    foreach (var book in Mockup.Mockup.books)
        //    {
        //        if (book.ISBN == ISBN)
        //            return book;
        //    }
        //    return null;
        //}

        //public static bool DeleteBook(string isbn)
        //{
        //    return false;
        //}

        //public static List<Book> GetBooks(Book book)
        //{
        //
        //    book.Title = book.Title == null ? "" : book.Title.ToLower();
        //    book.ISBN = book.ISBN == null ? "" : book.ISBN.ToLower();
        //    book.PublicationYear = book.PublicationYear == null ? "" : book.PublicationYear;
        //
        //    var books = new List<Book>();
        //    foreach(var b in Mockup.Mockup.books)
        //    {
        //        var title = b.Title.ToLower();
        //        var isbn = b.ISBN.ToLower();
        //        var year = b.PublicationYear;
        //        var cat = b.Classification;
        //
        //        if(title.Contains(book.Title) && isbn.Contains(book.ISBN) && year.Contains(b.PublicationYear) && (cat.Id == book.Classification.Id || book.Classification.Id == -1))
        //            books.Add(b);
        //
        //    }
        //
        //    return books;
        //}

        //public static List<Book> GetBooks(Author author)
        //{
        //    if(Mockup.Mockup.authors[0].Books == null)
        //    {
        //        Mockup.Mockup.authors[0].Books = new List<Book> { Mockup.Mockup.books[0] };
        //        Mockup.Mockup.authors[1].Books = new List<Book> { Mockup.Mockup.books[1], Mockup.Mockup.books[2] };
        //        Mockup.Mockup.authors[2].Books = new List<Book> { Mockup.Mockup.books[2] };
        //    }
        //    string firstName =  author.FirstName == null ? "" : author.FirstName.ToLower();
        //    string lastName = author.LastName == null ? "" : author.LastName.ToLower();
        //    var books = new List<Book>();
        //    foreach(var au in Mockup.Mockup.authors)
        //    {
        //        string fname = au.FirstName.ToLower();
        //        string lname = au.LastName.ToLower();
        //
        //        if (fname.Contains(firstName) && lname.Contains(lastName))
        //        {
        //            foreach(var b in au.Books)
        //            {
        //                if (!books.Contains(b))
        //                    books.Add(b);
        //            }
        //        }
        //            //books.AddRange(au.Books);
        //    }
        //    return books;
        //}
    }
}
