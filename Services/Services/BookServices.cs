using System.Collections.Generic;
using Common.Models;
using Repository.EntityModels;
using AutoMapper;
using System;
using Services.Exceptions;

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

        public static void Upsert(EditBookViewModel editBookViewModel, bool overwriteExisting)
        {
            if (!overwriteExisting)
            {
                Book tmp;
                Book.GetBook(out tmp, editBookViewModel.ISBN);
                if (tmp != null)
                {
                    throw new AlreadyExistsException("Aj, aj! En bok med angivet ISBN finns redan!");
                }
            }

            Book book = Mapper.Map<Book>(editBookViewModel);
            bool success = true;
            try
            {
                success = Book.Upsert(book, editBookViewModel.AuthorIds);
            }
            catch (ArgumentException e)
            {
                if (e.ParamName == "authorIdList")
                    throw new NoSuchAuthorException("De angivna författarna finns inte i databasen.");
                else
                    throw;
            }

            if (!success)
                throw new UpsertFailedException("Tusan! Något gick fel när en bok skulle skapas eller uppdateras. Kontakta en administratör om felet kvarstår.");
        }

        public static bool Delete(string isbn)
        {
            return Book.Delete(isbn);
        }

        public static List<BookViewModel> SearchBooks(string search)
        {
            List<Book> bookList = null;
            List<Tuple<string, string>> bookAuthorList;
            if (Book.SearchBook(out bookList, out bookAuthorList, search))
            {
                List<BookViewModel> bookViewModelList = new List<BookViewModel>();
                // Convert all books into bookviewmodels
                foreach (Book book in bookList)
                {
                    BookViewModel bookView = Mapper.Map<BookViewModel>(book);
                    int i = 0;
                    // Add authors 
                    foreach(var item in bookAuthorList)
                    {
                        if(bookView.ISBN == item.Item2)
                        {
                            bookView.Authors.Add(i, item.Item1);
                        }
                        ++i;
                    }
                    bookViewModelList.Add(bookView);
                }
                return bookViewModelList;
            }

            return null;
        }
    }
}
