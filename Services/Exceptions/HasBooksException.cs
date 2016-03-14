using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Exceptions
{
    public class HasBooksException : Exception
    {
        public HasBooksException()
        {

        }

        public HasBooksException(string message)
            : base(message)
        {
        }

        public HasBooksException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
