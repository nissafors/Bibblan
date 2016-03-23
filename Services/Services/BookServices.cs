using AutoMapper;
using Common.Models;
using Repository.EntityModels;
using Services.Exceptions;
using System;
using System.Collections.Generic;

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
        /// <exception cref="Services.Exceptions.DoesNotExistException">
        /// Thrown when a book or its authors could not be found.</exception>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static EditBookViewModel GetEditBookViewModel(string isbn)
        {
            EditBookViewModel ebvm = new EditBookViewModel();
            Book book = new Book();

            if (!Book.GetBook(out book, isbn))
                throw new DataAccessException("Ett oväntat fel uppstod när en bok skulle hämtas.");
            if (book == null)
                throw new DoesNotExistException("Ajdå! Boken hittades inte.");

            var bookAuthors = new List<BookAuthor>();
            if (!BookAuthor.GetBookAuthors(out bookAuthors, book.ISBN))
                throw new DataAccessException("Ett oväntat fel uppstod när författare till en bok skulle hämtas.");
            if (bookAuthors.Count < 1)
                throw new DoesNotExistException("Mystiskt! Angivna författare kunde inte hittas.");

            var authorIds = new List<int>();
            foreach (BookAuthor ba in bookAuthors)
                authorIds.Add(ba.Aid);

            ebvm = Mapper.Map<EditBookViewModel>(book);
            ebvm.AuthorIds = authorIds;

            return ebvm;
        }

        /// <summary>
        /// Get all books.
        /// </summary>
        /// <returns>Returns a list of BookViewModel:s.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
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
            else
            {
                throw new DataAccessException("Oväntat fel när böckerna hämtades. Kontakta administratör om felet kvarstår.");
            }
        }

        /// <summary>
        /// Gets all details for the specified book.
        /// </summary>
        /// <param name="isbn">The ISBN of the book as a string.</param>
        /// <returns>Returns a BookViewModel.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        /// <exception cref="Services.Exceptions.DoesNotExistException">
        /// Thrown when there's no book with given ISBN in the database.</exception>
        public static BookViewModel GetBookDetails(string isbn)
        {
            
            BookViewModel bookViewModel = null;
            Book book;
            Classification classification;
            List<BookAuthor> bookAuthorList;

            if (!Book.GetBook(out book, isbn))
                throw new DataAccessException("Oväntat fel. Info om en bok kunde inte hämtas.");
            if (book == null)
                throw new DoesNotExistException("Nähä, du! Den boken finns inte i databasen.");

            if (!BookAuthor.GetBookAuthors(out bookAuthorList, book.ISBN))
                throw new DataAccessException("Oväntat fel. Info om bokens författare kunde inte hämtas.");

            if (!Classification.GetClassification(out classification, book.SignId))
                throw new DataAccessException("Oväntat fel. Bokens klassifikation kunde inte hämtas.");

            bookViewModel = Mapper.Map<BookViewModel>(book);
            bookViewModel.Classification = classification == null ? null : classification.Signum;
            foreach (BookAuthor bookAuthor in bookAuthorList)
            {
                Author author;
                if (Author.GetAuthor(out author, bookAuthor.Aid))
                    bookViewModel.Authors.Add(author.Aid, author.LastName + ", " + author.FirstName);
                else
                    throw new DataAccessException("Oväntat fel när info om en författare skulle hämtas.");
            }

            return bookViewModel;
        }

        /// <summary>
        /// Write a book to the database.
        /// </summary>
        /// <param name="editBookViewModel">The EditBookViewModel to write to the database.</param>
        /// <param name="overwriteExisting">If a book with given ISBN already exists, then overwrite it only
        /// if overwriteExisting is set to true.</param>
        /// <exception cref="Services.Exceptions.AlreadyExistsException">
        /// Thrown when the item already exists in the database and overwriteExisting is set to false.</exception>
        /// <exception cref="Services.Exceptions.DoesNotExistException">
        /// Thrown when the author ids in the viewmodel are invalid.</exception>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
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
                    throw new DoesNotExistException("De angivna författarna finns inte i databasen.");
                else
                    throw;
            }

            if (!success)
                throw new DataAccessException("Tusan! Något gick fel när en bok skulle skapas eller uppdateras. Kontakta en administratör om felet kvarstår.");
        }

        /// <summary>
        /// Delete a book from the database.
        /// </summary>
        /// <param name="isbn">The ISBN of the book to delete.</param>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static void Delete(string isbn)
        {
            if (!Book.Delete(isbn))
                throw new DataAccessException("Oväntat fel när en bok skulle tas bort.");
        }

        /// <summary>
        /// Search for books using given search string and return the result.
        /// </summary>
        /// <param name="search">The search string.</param>
        /// <returns>Returns a list of BookViewModel:s.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
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

            throw new DataAccessException("Oväntat fel vid sökning av böcker.");
        }
    }
}
