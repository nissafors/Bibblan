using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using AutoMapper;

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

            if(Author.GetAuthors(out authorEntities) && authorEntities != null)
            {
                // build list
                foreach(var author in authorEntities)
                {
                    authors.Add(new AuthorViewModel { FirstName = author.FirstName, LastName = author.LastName, BirthYear = author.BirthYear, Aid = author.Aid });
                }
            }

            return authors;
        }

        public static AuthorViewModel GetAuthor(int authorId)
        {
            Author author;

            if(Author.GetAuthor(out author, authorId)
                && author != null)
            {
                return Mapper.Map<AuthorViewModel>(author);
            }
            return null;
        }

        public static List<AuthorViewModel> SearchAuthors(string search)
        {
            List<Author> authorList;
            if(Author.GetAuthors(out authorList, search))
            {
                List<AuthorViewModel> authorViewModelList = new List<AuthorViewModel>();
                foreach(Author author in authorList)
                {
                    authorViewModelList.Add(Mapper.Map<AuthorViewModel>(author));
                }

                return authorViewModelList;
            }
            return null;
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

        static public bool DeleteAuthor(string AuthorID)
        {
            int Aid;

            if (int.TryParse(AuthorID, out Aid))
            {
                return Author.Delete(Aid);
            }

            return false;
        }
    }
}
