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
            BorrowerViewModel borrowerViewModel = null;
            if (Borrower.GetBorrower(out borrower, personId) &&
                borrower != null &&
                Category.GetCategories(out categoryList))
            {
                borrowerViewModel = Mapper.Map<BorrowerViewModel>(borrower);
                borrowerViewModel.Category = new SelectList(categoryList.OrderBy(x => x.CategoryName), "CategoryId", "CategoryName");
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
        static public bool Upsert(BorrowerViewModel model)
        {
            return Borrower.Upsert(Mapper.Map<Borrower>(model));
        }
        
        static public bool Delete(BorrowerViewModel model)
        {
            return false;
        }
    }
}
