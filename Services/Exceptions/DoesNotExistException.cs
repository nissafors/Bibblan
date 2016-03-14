using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Exceptions
{
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
