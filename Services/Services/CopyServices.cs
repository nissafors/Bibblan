using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;

namespace Services.Services
{
    public class CopyServices
    {
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
    }
}
