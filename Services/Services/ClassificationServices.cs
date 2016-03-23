using Repository.EntityModels;
using Services.Exceptions;
using System.Collections.Generic;

namespace Services.Services
{
    public class ClassificationServices
    {
        /// <summary>
        /// Get classification ids and names as key-value pairs.
        /// </summary>
        /// <returns>Returns a dictionary with ids as keys and names as values.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static Dictionary<int, string> GetClassificationsAsDictionary()
        {
            var dic = new Dictionary<int, string>();
            List<Classification> cl;

            if (!Classification.GetClassifications(out cl))
                throw new DataAccessException("Oväntat fel när klassifikationer skulle hämtas.");

            foreach (Classification c in cl)
                dic.Add(c.SignId, c.Signum);

            return dic;
        }
    }
}
