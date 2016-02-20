using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;

namespace Services.Services
{
    public class BorrowerServices
    {
        public Borrower GetBorrowerById(string personId)
        {
            Borrower returnBorrower = null;

            foreach(Borrower borrower in Mockup.Mockup.borrowers)
            { 
                if(borrower.PersonId == personId)
                {
                    returnBorrower = borrower;
                    break;
                }
            }

            return returnBorrower;
        }

        public bool DeleteBorrower(string PersonId)
        {
            return false;
        }
    }
}
