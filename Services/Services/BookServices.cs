using System.Collections.Generic;
using Common.Models;
using Repository.EntityModels;
using AutoMapper;

namespace Services.Services
{
    public class BookServices
    {
        /// <summary>
        /// Get an EditBookViewModel object from given isbn.
        /// If no book can be found, return an empty EditBookViewModel.
        /// </summary>
        /// <remarks>
        /// Does not fill out the Copies property!
        /// </remarks>
        /// <param name="isbn">ISBN as a string.</param>
        /// <returns>EditBookViewModel</returns>
        public static EditBookViewModel GetEditBookViewModel(string isbn)
        {
            EditBookViewModel ebvm = new EditBookViewModel();
            Book book = new Book();
            var authorIds = new List<int>();
            
            if (Book.GetBook(out book, isbn))
            {
                var bookAuthors = new List<BookAuthor>();

                ebvm = Mapper.Map<EditBookViewModel>(book);

                if (BookAuthor.GetBookAuthors(out bookAuthors, book.ISBN))
                {
                    foreach(BookAuthor ba in bookAuthors)
                        authorIds.Add(ba.Aid);
                }

                ebvm.AuthorIds = authorIds;
            }

            return ebvm;
        }

        public static List<BookViewModel> GetBooks()
        {
            List<Book> bookList;
            if(Book.GetBooks(out bookList))
            {
                List<BookViewModel> bookViewModelList = new List<BookViewModel>();
                foreach(Book book in bookList)
                {
                    bookViewModelList.Add(Mapper.Map<BookViewModel>(book));
                }
                return bookViewModelList;
            }
            return null;
        }

        /// <summary>
        /// Gets all details for the specified book and returns it as a BookViewModel
        /// </summary>
        /// <param name="isbn">ISBN of the book to get details on</param>
        /// <returns>A BookViewModel containing all the details</returns>
        public static BookViewModel GetBookDetails(string isbn)
        {
            
            BookViewModel bookViewModel = null;
            Book book;
            Classification classification;
            List<BookAuthor> bookAuthorList;

            if(Book.GetBook(out book, isbn) && 
                BookAuthor.GetBookAuthors(out bookAuthorList, book.ISBN) &&
                Classification.GetClassification(out classification, book.SignId))
            {
                bookViewModel = Mapper.Map<BookViewModel>(book);
                bookViewModel.Classification = classification.Signum;
                foreach (BookAuthor bookAuthor in bookAuthorList)
                {
                    Author author;
                    if (Author.GetAuthor(out author, bookAuthor.Aid))
                    {
                        bookViewModel.Authors.Add(author.Aid, author.LastName + ", " + author.FirstName);
                    }
                }
            }

            return bookViewModel;
        }

        public static bool Upsert(EditBookViewModel editBookViewModel)
        {
            Book book = Mapper.Map<Book>(editBookViewModel);
            return Book.Upsert(book, editBookViewModel.AuthorIds);
        }

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
