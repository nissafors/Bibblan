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
        public Author GetAuthorById(int id)
        {
            return Mockup.Mockup.authors[id - 1];
        }

        public List<Author> GetAuthors()
        {
            return Mockup.Mockup.authors;
        }

        static public bool DeleteAuthor(string AuthorID)
        {
            return false;
        }
    }
}
