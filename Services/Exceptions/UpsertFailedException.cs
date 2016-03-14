using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Exceptions
{
    class UpsertFailedException : Exception
    {
        public UpsertFailedException()
        {

        }

        public UpsertFailedException(string message)
            : base(message)
        {
        }

        public UpsertFailedException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
