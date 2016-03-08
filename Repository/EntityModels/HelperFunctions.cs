using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.EntityModels
{
    class HelperFunctions
    {
        static public string SetupSearchString(string search)
        {
            string modifiedSearch = "%";
            foreach (char character in search)
            {
                if (char.IsWhiteSpace(character))
                {
                    modifiedSearch += "%";
                }
                else
                {
                    modifiedSearch += character;
                }
            }
            modifiedSearch += "%";

            return modifiedSearch;
        }
    }
}
