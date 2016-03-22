using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Repository.EntityModels;
using Common.Models;
using AutoMapper;
using Services.Exceptions;

namespace Services.Services
{
    public class BorrowServices
    {
        /// <summary>
        /// Renew a loan.
        /// </summary>
        /// <param name="borrow">The BorrowViewModel for the loan.</param>
        /// <exception cref="Services.Exceptions.DoesNotExistException">
        /// Thrown when the borrower or it's category could not be found.</exception>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static void Renew(BorrowViewModel borrow)
        {
            Borrower borrower;
            Category category;
            if(!Borrower.GetBorrower(out borrower, borrow.PersonId))
                throw new DataAccessException("Oväntat fel när en låntagare skulle hämtas.");
            if (!Category.GetCategory(out category, borrower.CategoryId))
                throw new DataAccessException("Oväntat fel när kategorin skulle hämtas.");
            if (borrower == null)
                throw new DoesNotExistException("Nädu! Den låntagaren finns inte.");
            if (category == null)
                throw new DoesNotExistException("Låntagaren är inte kategoriserad. Kontakta en administratör.");
            
            borrow.ToBeReturnedDate = DateTime.Now.AddDays(category.Period);
            if (!Borrow.UpdateReturnDate(Mapper.Map<Borrow>(borrow)))
                throw new DataAccessException("Oväntat fel när ett lån skulle förnyas.");
        }

        /// <summary>
        /// Get a persons loans.
        /// </summary>
        /// <param name="personId">The id of the person.</param>
        /// <param name="activeOnly">Wether to get only the currently active loans</param>
        /// <returns>Returns a List of BorrowViewModels:s.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static List<BorrowViewModel> GetBorrows(string personId, bool activeOnly = false)
        {
            List<Borrow> borrows;
            var borrowvms = new List<BorrowViewModel>();
            bool result = false;

            if (activeOnly)
                result = Borrow.GetActiveBorrows(out borrows, personId);
            else
                result = Borrow.GetBorrows(out borrows, personId);

            if (result)
            {
                foreach(var borrow in borrows)
                {
                    var viewmodel = Mapper.Map<BorrowViewModel>(borrow);
                    Copy copy;
                    if (!Copy.GetCopy(out copy, borrow.Barcode))
                        throw new DataAccessException("Oväntat fel när info om ett lånat exemplar skulle hämtas.");

                    Book book;
                    if (!Book.GetBook(out book, copy.ISBN))
                        throw new DataAccessException("Oväntat fel när info om en lånad bok skulle hämtas.");

                    viewmodel.Title = book.Title;
                    borrowvms.Add(viewmodel);
                }
            }
            else
                throw new DataAccessException("Oväntat fel när lån skulle hämtas.");

            return borrowvms;
        }
    }
}
