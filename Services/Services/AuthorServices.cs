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
            /*
            if(Author.GetAuthor(out authorEntities) && authorEntities != null)
            {
                // build list
                foreach(var author in authorEntities)
                {
                    authors.Add(new AuthorViewModel { FirstName = author.FirstName, LastName = author.LastName, BirthYear = author.BirthYear, Id = author.Aid });
                }
            }
            */
            return authors;

        }

        public static Dictionary<int, string> GetAuthorsAsDictionary()
        {
            var dic = new Dictionary<int, string>();
            List<Author> al;

            if (Author.GetAuthors(out al))
        {
                foreach (Author a in al)
                    dic.Add(a.Aid, a.FirstName + " " + a.LastName);
            }

            return dic;
        }
        /*
        public List<Author> GetAuthors()
        {
            return Mockup.Mockup.authors;
        }
        */
        static public bool DeleteAuthor(string AuthorID)
        {
            return false;
        }
    }
}
