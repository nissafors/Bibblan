// TODO:
// Document and revise Renew()

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
        public static bool Renew(BorrowViewModel borrow)
        {
            Borrower borrower;
            Category category;
            if(Borrower.GetBorrower(out borrower, borrow.PersonId) &&
                borrower != null &&
                Category.GetCategory(out category, borrower.CategoryId))
            {
                borrow.ToBeReturnedDate = DateTime.Now.AddDays(category.Period);
                return Borrow.UpdateReturnDate(Mapper.Map<Borrow>(borrow));
            }

            return false;
        }

        /// <summary>
        /// Get a persons loans.
        /// </summary>
        /// <param name="personId">The id of the person.</param>
        /// <returns>Returns a List of BorrowViewModels:s.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static List<BorrowViewModel> GetBorrows(string personId)
        {
            List<Borrow> borrows;
            var borrowvms = new List<BorrowViewModel>();
            if (Borrow.GetBorrows(out borrows, personId))
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
