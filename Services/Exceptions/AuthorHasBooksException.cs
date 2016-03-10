using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Exceptions
{
    public class AuthorHasBooksException : Exception
    {
        public AuthorHasBooksException()
        {

        }

        public AuthorHasBooksException(string message)
            : base(message)
        {
        }

        public AuthorHasBooksException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
