using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Exceptions.BorrowerException
{
    public class AlreadyExistException : Exception
    {
        public AlreadyExistException()
        {

        }

        public AlreadyExistException(string message)
            : base(message)
        {
        }

        public AlreadyExistException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }

    public class DoesNotExistException : Exception
    {
        public DoesNotExistException()
        {

        }

        public DoesNotExistException(string message)
            : base(message)
        {
        }

        public DoesNotExistException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
