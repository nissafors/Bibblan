using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using Repository.Repositories;

namespace Services.Services
{
    public class BookServices
    {
        public static List<BookViewModel> GetBookViewModels(string search)
        {
            /* TODO: EVERYTHING
            List<Book> books;
            List<BookViewModel> models;
            if(Book.GetBooks(out books) && books != null)
            {
                var model = new BookViewModel();
                List<Author> authors;
                Author.GetAuthor(;
                model.Authors = 
            }*/
            return null;

        }

        public static EditBookViewModel GetEditBookViewModel(string isbn)
        {
            EditBookViewModel ebvm = new EditBookViewModel();
            Book book = new Book();
            var authorIds = new List<int>();
            
            if (Book.GetBook(out book, isbn))
            {
                var bookAuthors = new List<BookAuthor>();

                if (BookAuthor.GetBookAuthors(out bookAuthors, book.ISBN))
                {
                    foreach(BookAuthor ba in bookAuthors)
                        authorIds.Add(ba.Aid);
                }

                List<Copy> copies;
                if (Copy.GetCopies(out copies, isbn))
                {
                    var cvms = ebvm.Copies;
                    foreach (Copy copy in copies)
                    {
                        cvms.Add(new CopyViewModel()
                        {
                            BarCode = copy.Barcode,
                            Location = copy.Location,
                            StatusId = copy.StatusId,
                            ISBN = copy.ISBN,
                            Library = copy.Library
                        });
                    }

                    ebvm.Copies = cvms;
                }

                ebvm.ISBN = book.ISBN;
                ebvm.Title = book.Title;
                ebvm.ClassificationId = book.SignId;
                ebvm.PublicationYear = book.PublicationYear;
                ebvm.PublicationInfo = book.PublicationInfo;
                ebvm.Pages = book.Pages;
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
                    bookViewModelList.Add(new BookViewModel()
                    {
                        ISBN = book.ISBN,
                        Title = book.Title,
                        Pages = book.Pages,
                        PublicationInfo = book.PublicationInfo,
                        PublicationYear = book.PublicationYear,
                    });
                }
                return bookViewModelList;
            }
            return null;
        }

        public static BookViewModel GetBookDetails(string isbn)
        {
            Book book = null;
            BookViewModel bookViewModel = null;
            Classification classification = null;
            List<BookAuthor> bookAuthorList;

            List<Classification> classList;
            Classification.GetClassifications(out classList);

            if(Book.GetBook(out book, isbn) && 
                BookAuthor.GetBookAuthors(out bookAuthorList, book.ISBN) &&
                Classification.GetClassification(out classification, book.SignId))
            {
                bookViewModel = new BookViewModel()
                {
                    ISBN = book.ISBN,
                    Title = book.Title,
                    SignId = book.SignId,
                    Classification = classification.Signum,
                    Pages = book.Pages,
                    PublicationInfo = book.PublicationInfo,
                    PublicationYear = book.PublicationYear
                };

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
