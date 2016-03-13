using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using AutoMapper;
using System.Data.SqlClient;

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

            if (Author.GetAuthors(out authorEntities) && authorEntities != null)
            {
                // build list
                foreach (var author in authorEntities)
                {
                    authors.Add(new AuthorViewModel { FirstName = author.FirstName, LastName = author.LastName, BirthYear = author.BirthYear, Aid = author.Aid });
                }
            }

            return authors;
        }

        public static AuthorViewModel GetAuthor(int authorId)
        {
            Author author;

            if (Author.GetAuthor(out author, authorId)
                && author != null)
            {
                return Mapper.Map<AuthorViewModel>(author);
            }
            return null;
        }

        public static List<AuthorViewModel> SearchAuthors(string search)
        {
            List<Author> authorList;
            if (Author.GetAuthors(out authorList, search))
            {
                List<AuthorViewModel> authorViewModelList = new List<AuthorViewModel>();
                foreach (Author author in authorList)
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

        public static bool Upsert(AuthorViewModel authorViewModel)
        {
            Author author = Mapper.Map<Author>(authorViewModel);
            try
            {
                Author existingAuthor = null;
                if(Author.GetAuthor(out existingAuthor, author.Aid) &&
                    existingAuthor != null)
                {

                }
            }
            catch(Exception)
            {
                throw;
            }

            return false;
        }

        public static bool DeleteAuthor(string AuthorID)
        {
            int Aid;
            List<BookAuthor> bookAuthorList;
            try
            {
                if (int.TryParse(AuthorID, out Aid) &&
                    BookAuthor.GetBookAuthors(out bookAuthorList, Aid))
                {
                    if (bookAuthorList.Count == 0)
                    {
                        if (Author.Delete(Aid))
                        {
                            return true;
                        }
                    }
                    else
                    {
                        throw new Exceptions.AuthorException.HasBooksException("Författaren kan inte tas bort då han eller hon har böcker.");
                    }
                }
                throw new Exceptions.AuthorException.DoesNotExistException("Författaren som skulle tas bort hittades inte.");
            }
            catch (SqlException)
            {
                // Database error
                return false;
            }
            catch (Exception)
            {
                // Rethrow the exception
                throw;
            }
        }
    }
}
