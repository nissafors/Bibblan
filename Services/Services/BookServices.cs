using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;

namespace Services.Services
{
    public class BookServices
    {
        public List<Book> GetBooks()
        {
            return Mockup.Mockup.books;
        }
    }
}
