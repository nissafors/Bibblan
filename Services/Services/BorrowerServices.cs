// TODO:
// Document and revise Upsert()

using AutoMapper;
using Common.Models;
using Repository.EntityModels;
using Services.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Services
{
    public class BorrowerServices
    {
        /// <summary>
        /// Get a viewmodel for a specific borrower
        /// </summary>
        /// <param name="personId">The id of the borrower as a string.</param>
        /// <returns>Returns a BorrowerViewModel.</returns>
        /// <exception cref="Services.Exceptions.DoesNotExistException">
        /// Thrown when a borrower with given personId could not be found.</exception>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        static public BorrowerViewModel GetBorrower(string personId)
        {
            Borrower borrower;
            BorrowerViewModel borrowerViewModel = null;
            if (Borrower.GetBorrower(out borrower, personId))
            {
                if (borrower != null)
                {
                    borrowerViewModel.Borrows = BorrowServices.GetBorrows(personId);
                    borrowerViewModel = Mapper.Map<BorrowerViewModel>(borrower);
                }
                else
                {
                    throw new DoesNotExistException("Kunde inte hitta den eftersökta låntagaren");
                }
            }
            else
                throw new DataAccessException("Oväntat fel när en låntagare skulle hämtas.");

            return borrowerViewModel;
        }

        /// <summary>
        /// Search for all borrowers matching a search string.
        /// </summary>
        /// <param name="search">The search string.</param>
        /// <returns>Returns a List of BorrowerViewModel:s.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        static public List<BorrowerViewModel> SearchBorrowers(string search)
        {
            List<Borrower> borrowerList;
            if (Borrower.GetBorrowers(out borrowerList, search))
            {
                List<BorrowerViewModel> borrowerViewList = new List<BorrowerViewModel>();

                foreach (Borrower borrower in borrowerList)
                {
                    BorrowerViewModel borrowerView = Mapper.Map<BorrowerViewModel>(borrower);
                    borrowerViewList.Add(borrowerView);
                }

                return borrowerViewList;
            }
            else
                throw new DataAccessException("Oväntat fel vid boksökning.");
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
                if (Borrower.GetBorrower(out existingBorrower, borrower.PersonId))
                {
                    if (existingBorrower != null)
                    {
                        throw new AlreadyExistsException("En låntagare med det personnumret finns redan.");
                    }
                }
                else
                {
                    // throw new DataAccessException("");
                }
            }
            
            if(!Borrower.Upsert(borrower))
            {
                throw new DoesNotExistException("Kunde inte uppdatera låntagaren.");
            }
        }
        
        /// <summary>
        /// Remove a borrower from the database.
        /// </summary>
        /// <param name="PersonId">The id of the borrower as a string.</param>
        /// <exception cref="Services.Exceptions.DoesNotExistException">
        /// Thrown when delete failed.</exception>
        static public void Delete(string PersonId)
        {
            if(!Borrower.Delete(PersonId))
                throw new DoesNotExistException("Låntagaren med personnummer " + PersonId + " kunde inte tas bort.");
        }
    }
}
