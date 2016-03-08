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
    }
}
