using System;

namespace Services.Exceptions
{
    /// <summary>
    /// The exception that is thrown when an item that should exist doesn't.
    /// </summary>
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
