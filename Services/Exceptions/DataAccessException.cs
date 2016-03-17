using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Exceptions
{
    /// <summary>
    /// The exception that is thrown when a request to the data access layer returns false, indicating an error.
    /// </summary>
    public class DataAccessException : Exception
    {
        public DataAccessException()
        {

        }

        public DataAccessException(string message)
            : base(message)
        {
        }

        public DataAccessException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
