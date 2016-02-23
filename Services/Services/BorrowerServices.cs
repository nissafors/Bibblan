using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using System.Data.SqlClient;

namespace Services.Services
{
   public class BorrowerServices
   {
      static public Borrower GetBorrowerById(string personId)
      {
         
         Borrower returnBorrower = null;

         foreach (Borrower borrower in Mockup.Mockup.borrowers)
         {
            if (borrower.PersonId == personId)
            {
               returnBorrower = borrower;
               break;
            }
         }

         return returnBorrower;
      }

      static public List<Borrower> GetBorrowers()
      {
         return Mockup.Mockup.borrowers;
      }

      static public List<Borrower> GetBorrowers(Borrower borrower)
      {
         Repository.Repositories.DatabaseConnection connection = new Repository.Repositories.DatabaseConnection();
         connection.connect();
         return Mockup.Mockup.borrowers;
      }

      static public bool AddBorrower(Borrower borrower)
      {
         return false;
      }

      static public bool DeleteBorrower(string PersonId)
      {
         return false;
      }
   }
}
