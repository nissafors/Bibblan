using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using AutoMapper;

namespace Services.Services
{
    public class CopyServices
    {
        /// <summary>
        /// Get CopyViewModels from given isbn, or an empty List<> if no copies where found.
        /// </summary>
        /// <param name="isbn">ISBN as a string.</param>
        /// <returns>A List of CopyViewModel's</returns>
        public static List<CopyViewModel> getCopyViewModels(string isbn)
        {
            var cvms = new List<CopyViewModel>();
            List<Copy> copies;
            if (Copy.GetCopies(out copies, isbn))
            {
                foreach (Copy copy in copies)
                {
                    cvms.Add(Mapper.Map<CopyViewModel>(copy));
                }
            }

            return cvms;
        }

        public static CopyViewModel GetCopyViewModel(string barCode)
        {
            var cvm = new CopyViewModel();
            var copy = new Copy();
            if (Copy.GetCopy(out copy, barCode))
            {
                cvm = Mapper.Map<CopyViewModel>(copy);
            }

            return cvm;
        }

        public static void Upsert(CopyViewModel copyViewModel, bool overwriteExisting)
        {
            Copy tmp;
            if (!overwriteExisting)
            {
                Copy.GetCopy(out tmp, copyViewModel.BarCode);
                if (tmp != null)
                    throw new Exceptions.AlreadyExistsException("Har man sett! Ett exemplar med denna streckkod finns redan.");
            }

            Copy copy = Mapper.Map<Copy>(copyViewModel);
            if (!Copy.Upsert(copy))
            {
                throw new Exceptions.UpsertFailedException("Hoppsan! Något gick galet när ett exemplar skulle skapas eller uppdateras. Kontakta en administratör om problemet kvarstår.");
            }
        }

        public static bool DeleteCopy(string barcode)
        {
            return Copy.Delete(barcode);
        }
    }
}
