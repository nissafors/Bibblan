﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
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

      static public List<BorrowerViewModel> GetBorrowers(BorrowerViewModel searchBorrower)
      {
          // TODO: Get from database
          List<BorrowerViewModel> borrowerList = new List<BorrowerViewModel>();
          foreach (Repository.EntityModels.Borrower borrower in Mockup.Mockup.borrowers)
          {
              borrowerList.Add(
                  new BorrowerViewModel(new Dictionary<int, string>()
                  {
                      {Mockup.Mockup.categories[0].Id, Mockup.Mockup.categories[0].CategoryName},
                      {Mockup.Mockup.categories[1].Id, Mockup.Mockup.categories[1].CategoryName},
                      {Mockup.Mockup.categories[2].Id, Mockup.Mockup.categories[2].CategoryName},
                      {Mockup.Mockup.categories[3].Id, Mockup.Mockup.categories[3].CategoryName}
                  })
                  {
                      PersonId=borrower.PersonId,
                      FirstName=borrower.FirstName,
                      LastName=borrower.LastName,
                      Adress=borrower.Adress,
                      SelectedCategory=borrower.CategoryId,
                      TelephoneNumber=borrower.TelNo
                  });
          }
          return borrowerList;
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
