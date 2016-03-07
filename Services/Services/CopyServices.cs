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
        /*
        public static Copy GetCopy(string barcode)
        {
            Copy returnCopy = null;

            foreach(Copy copy in Mockup.Mockup.copies)
            {
                if(copy.BarCode == barcode)
                {
                    returnCopy = copy;
                    break;
                }
            }

            if (returnCopy != null)
                returnCopy.Book = Mockup.Mockup.books[2];

            return returnCopy;
        }

        public static bool DeleteCopy(string BarCode)
        {
            return false;
        }
        */
    }
}
