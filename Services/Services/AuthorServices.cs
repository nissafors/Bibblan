using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
namespace Services.Services
{
    public class AuthorServices
    {
        public Author getAuthorById(int id)
        {
            return Mockup.Mockup.authors[id - 1];
        }
    }
}
