using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Exceptions
{
    class NoSuchAuthorException : Exception
    {
        public NoSuchAuthorException()
        {

        }

        public NoSuchAuthorException(string message)
            : base(message)
        {
        }

        public NoSuchAuthorException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
