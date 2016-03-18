using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using AutoMapper;
using Services.Exceptions;

namespace Services.Services
{
    public class CopyServices
    {
        /// <summary>
        /// Get all CopyViewModels associated with given isbn, or an empty List if no copies where found.
        /// </summary>
        /// <param name="isbn">ISBN as a string.</param>
        /// <returns>A List of CopyViewModel:s.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static List<CopyViewModel> getCopyViewModels(string isbn)
        {
            var cvms = new List<CopyViewModel>();
            List<Copy> copies;
            if (!Copy.GetCopies(out copies, isbn))
                throw new DataAccessException("Oväntat fel när exemplar av en bok skulle hämtas.");

            foreach (Copy copy in copies)
            {
                cvms.Add(Mapper.Map<CopyViewModel>(copy));
            }

            return cvms;
        }

        /// <summary>
        /// Get the copy with given barcode.
        /// </summary>
        /// <param name="barcode">The barcode of the copy.</param>
        /// <returns>Returns a CopyViewModel.</returns>
        /// <exception cref="Services.Exceptions.DoesNotExistException">
        /// Thrown when no copy with given barcode could be found.</exception>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static CopyViewModel GetCopyViewModel(string barcode)
        {
            var cvm = new CopyViewModel();
            var copy = new Copy();
            if (Copy.GetCopy(out copy, barcode))
            {
                if (copy == null)
                    throw new DoesNotExistException("Ett exemplar med angiven streckkod finns inte i databasen.");

                cvm = Mapper.Map<CopyViewModel>(copy);
            }
            else
                throw new DataAccessException("Oväntat fel när ett exemplar skulle hämtas.");

            return cvm;
        }

        /// <summary>
        /// Update or insert a copy in the database.
        /// </summary>
        /// <param name="copyViewModel">The copy to upsert.</param>
        /// <param name="overwriteExisting">If a copy with given barcode already exists: only overwrite it if
        /// overwriteExisting is set to true.</param>
        /// <exception cref="Services.Exceptions.AlreadyExistsException">
        /// Thrown when overwriteExisting is set to false and there's already a copy with given barcode in
        /// the database.</exception>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static void Upsert(CopyViewModel copyViewModel, bool overwriteExisting)
        {
            Copy tmp;
            if (!overwriteExisting)
            {
                if (!Copy.GetCopy(out tmp, copyViewModel.BarCode))
                    throw new DataAccessException("Oväntat fel när en kopia skulle hämtas.");
                if (tmp != null)
                    throw new AlreadyExistsException("Har man sett! Ett exemplar med denna streckkod finns redan.");
            }

            Copy copy = Mapper.Map<Copy>(copyViewModel);
            if (!Copy.Upsert(copy))
            {
                throw new DataAccessException("Oväntat fel när ett exemplar skulle skapas eller uppdateras.");
            }
        }

        /// <summary>
        /// Delete a copy from the database.
        /// </summary>
        /// <param name="barcode">The barcode of the copy as a string.</param>
        /// <exception cref="Services.Exceptions.DoesNotExistException">
        /// Thrown if delete failed.</exception>
        public static void DeleteCopy(string barcode)
        {
            if (!Copy.Delete(barcode))
                throw new DoesNotExistException("Kopian kunde inte tas bort.");
        }
    }
}
