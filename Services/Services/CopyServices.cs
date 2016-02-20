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
        public Copy GetCopy(string barcode)
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

            return Mockup.Mockup.copies[0];
        }

        static public bool DeleteCopy(string BarCode)
        {
            return false;
        }
    }
}
