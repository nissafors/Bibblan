using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Repository.EntityModels;
using Common.Models;
using AutoMapper;

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
                        throw new Exception("Could not get Copies");

                    Book book;
                    if (!Book.GetBook(out book, copy.ISBN))
                        throw new Exception("Could not get Book");

                    viewmodel.Title = book.Title;
                    borrowvms.Add(viewmodel);
                }
            }
            else
                throw new Exception("Could not get Loans");

            return borrowvms;
        }
    }
}
