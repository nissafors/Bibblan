using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Exceptions
{
    /// <summary>
    /// The exception that is thrown when the item that is being created already exists.
    /// </summary>
    public class AlreadyExistsException : Exception
    {
        public AlreadyExistsException()
        {

        }

        public AlreadyExistsException(string message)
            : base(message)
        {
        }

        public AlreadyExistsException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
