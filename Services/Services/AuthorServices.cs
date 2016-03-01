using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
namespace Services.Services
{
    public class AuthorServices
    {
        /// <summary>
        /// Returns a list of all authors in the database
        /// </summary>
        /// <returns></returns>
        public static List<AuthorViewModel> GetAuthors()
        {
            List<Author> authorEntities;
            List<AuthorViewModel> authors = new List<AuthorViewModel>();

            if(Author.GetAuthor(out authorEntities) && authorEntities != null)
            {
                // build list
                foreach(var author in authorEntities)
                {
                    authors.Add(new AuthorViewModel { FirstName = author.FirstName, LastName = author.LastName, BirthYear = author.BirthYear, Id = author.Aid });
                }
            }

            return authors;

        }
        /*
        public Author GetAuthorById(int id)
        {
            return Mockup.Mockup.authors[id - 1];
        }

        public static List<Author> GetAuthors(List<int> ids)
        {
            var authors = new List<Author>();

            if (ids == null)
                return authors;

            foreach(Author author in Mockup.Mockup.authors)
            {
                if (ids.Contains(author.Id))
                    authors.Add(author);
            }

            return authors;
        }

        public List<Author> GetAuthors()
        {
            return Mockup.Mockup.authors;
        }

        static public bool DeleteAuthor(string AuthorID)
        {
            return false;
        }
        */
    }
}
