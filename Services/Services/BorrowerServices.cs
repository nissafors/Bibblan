using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using System.Data.SqlClient;
using System.Web.Mvc;
using AutoMapper;
using Services.Exceptions;

namespace Services.Services
{
    public class BorrowerServices
    {
        /// <summary>
        /// Get a viewmodel for a specific borrower
        /// </summary>
        /// <param name="personId"></param>
        /// <returns></returns>
        static public BorrowerViewModel GetBorrower(string personId)
        {
            Borrower borrower;
            List<Category> categoryList;
            List<Borrow> borrowList;
            BorrowerViewModel borrowerViewModel = null;
            if (Borrower.GetBorrower(out borrower, personId) &&
                borrower != null &&
                Category.GetCategories(out categoryList) &&
                Borrow.GetBorrows(out borrowList, borrower.PersonId))
            {
                borrowerViewModel = Mapper.Map<BorrowerViewModel>(borrower);
                borrowerViewModel.Category = new SelectList(categoryList.OrderBy(x => x.CategoryName), "CategoryId", "CategoryName");
                
                foreach(Borrow borrow in borrowList)
                {
                    borrowerViewModel.Borrows.Add(Mapper.Map<BorrowViewModel>(borrow));
                }
            }

            return borrowerViewModel;
        }

        /// <summary>
        /// Get viewmodel with the category list filled for a borrower
        /// </summary>
        /// <returns></returns>
        static public BorrowerViewModel GetEmptyBorrower()
        {
            List<Category> categoryList;
            BorrowerViewModel borrowerViewModel = new BorrowerViewModel();
            if (Category.GetCategories(out categoryList))
            {
                borrowerViewModel.Category = new SelectList(categoryList.OrderBy(x => x.CategoryName), "CategoryId", "CategoryName");
                return borrowerViewModel;
            }
            else
            {
                return null;
            }
            
        }

        static public List<BorrowerViewModel> SearchBorrowers(string search)
        {
            List<Borrower> borrowerList;
            List<Category> categoryList;
            if (Borrower.GetBorrowers(out borrowerList, search) &&
                Category.GetCategories(out categoryList))
            {
                List<BorrowerViewModel> borrowerViewList = new List<BorrowerViewModel>();
                
                foreach (Borrower borrower in borrowerList)
                {
                    BorrowerViewModel borrowerView = Mapper.Map<BorrowerViewModel>(borrower);
                    borrowerView.Category = new SelectList(categoryList.OrderBy(x => x.CategoryName), "CategoryId", "CategoryName");
                    borrowerViewList.Add(borrowerView);
                }

                return borrowerViewList;
            }

            return null;
        }

        /// <summary>
        /// Update existing borrower or insert a new one
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        static public void Upsert(BorrowerViewModel viewModel)
        {
            Borrower borrower = Mapper.Map<Borrower>(viewModel);
            Account account = Mapper.Map<Account>(viewModel.Account);

            
            if (viewModel.New)
            {
                Borrower existingBorrower = null;
                Borrower.GetBorrower(out existingBorrower, borrower.PersonId);

                if(existingBorrower != null)
                {
                    throw new AlreadyExistsException("En låntagare med det personnumret finns redan.");
                }
            }
            
            if(!Borrower.Upsert(borrower))
            {
                throw new DoesNotExistException("Kunde inte uppdatera låntagaren.");
            }

            // TODO: Upsert account
        }
        
        static public bool Delete(string PersonId)
        {
            return Borrower.Delete(PersonId);
        }
    }
}
