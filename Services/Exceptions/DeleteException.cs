using System;

namespace Services.Exceptions
{
    /// <summary>
    /// The exception that is thrown when attempted to delete an item that is not in a deletable state.
    /// </summary>
    public class DeleteException : Exception
    {
        public DeleteException()
        {

        }

        public DeleteException(string message)
            : base(message)
        {
        }

        public DeleteException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
