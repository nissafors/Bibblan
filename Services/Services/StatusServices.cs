using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Repository.EntityModels;
using Services.Exceptions;

namespace Services.Services
{
    public class StatusServices
    {
        /// <summary>
        /// Get statuses as key-value pairs.
        /// </summary>
        /// <returns>Returns a dictionary with ids as keys and names as values.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static Dictionary<int, string> GetStatusesAsDictionary()
        {
            var dic = new Dictionary<int, string>();
            List<Status> sts;

            if (!Status.GetStatuses(out sts))
                throw new DataAccessException("Oväntat fel när statuslistan skulle hämtas.");

            foreach (Status st in sts)
                dic.Add(st.StatusId, st.StatusName);
            
            return dic;
        }
    }
}
