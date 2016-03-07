using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using Repository.Repositories;
using AutoMapper;

namespace Services.Services
{
    public class BookServices
    {
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

        public static bool Upsert(EditBookViewModel editBookModel)
        {
            Book book = Mapper.Map<Book>(editBookModel);
            return Book.Upsert(book, editBookModel.AuthorIds);
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
                    bookViewModelList.Add(Mapper.Map<BookViewModel>(book));
                    int i = 0;

                    // Add authors 
                    foreach(var item in bookAuthorList)
                    {
                        if(book.ISBN == item.Item2)
                        {
                            bookViewModelList[bookViewModelList.Count - 1].Authors.Add(i, item.Item1);
                        }
                        ++i;
                    }
                }
                return bookViewModelList;
            }

            return null;
        }
    }
}
