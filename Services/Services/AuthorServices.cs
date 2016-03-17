using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using AutoMapper;
using Services.Exceptions;

namespace Services.Services
{
    public class AuthorServices
    {
        /// <summary>
        /// Returns a list of all authors in the database
        /// </summary>
        /// <returns>A List of AuthorViewModel:s</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.
        /// </exception>
        public static List<AuthorViewModel> GetAuthors()
        {
            List<Author> authorEntities;
            List<AuthorViewModel> authors = new List<AuthorViewModel>();

            if (Author.GetAuthors(out authorEntities))
            {
                // build list
                foreach (var author in authorEntities)
                {
                    authors.Add(Mapper.Map<AuthorViewModel>(author));
                }

                return authors;
            }
            else
            {
                throw new DataAccessException("Oväntat fel när böckerna hämtades. Kontakta administratör om felet kvarstår.");
            }
        }

        /// <summary>
        /// Get author by id.
        /// </summary>
        /// <param name="authorId">The id of the author.</param>
        /// <returns>Returns an AuthorViewModel.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        /// <exception cref="Services.Exceptions.DoesNotExistException">
        /// Throw if no author with given id can be found.</exception>
        public static AuthorViewModel GetAuthor(int authorId)
        {
            Author author;

            if (!Author.GetAuthor(out author, authorId))
                throw new DataAccessException("Oväntat fel när författaren skulle hämtas.");
            if (author != null)
                throw new DoesNotExistException("En författare med angivet id kunde inte hittas.");

            return Mapper.Map<AuthorViewModel>(author);
        }

        /// <summary>
        /// Returns all authors that matches the conditions in a search string.
        /// </summary>
        /// <param name="search">The search string.</param>
        /// <returns>Returns a List of AuthorViewModel:s.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static List<AuthorViewModel> SearchAuthors(string search)
        {
            List<Author> authorList;
            if (!Author.GetAuthors(out authorList, search))
                throw new DataAccessException("Ett oväntat fel inträffade.");

            List<AuthorViewModel> authorViewModelList = new List<AuthorViewModel>();
            foreach (Author author in authorList)
            {
                authorViewModelList.Add(Mapper.Map<AuthorViewModel>(author));
            }

            return authorViewModelList;
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

        public static void Upsert(AuthorViewModel authorViewModel)
        {
            Author author = Mapper.Map<Author>(authorViewModel);

            if(author.Aid != 0)
            {
                if (!Author.Update(author))
                {
                    throw new DoesNotExistException("Författaren kunde inte uppdateras då han eller hon inte fanns.");
                }
            }
            else
            {
                if (!Author.Insert(author))
                {
                    throw new DoesNotExistException("Kunde inte skapa en ny författare.");
                }
            }
        }

        public static void DeleteAuthor(string AuthorID)
        {
            int Aid;
            List<BookAuthor> bookAuthorList;

            if (int.TryParse(AuthorID, out Aid) &&
                BookAuthor.GetBookAuthors(out bookAuthorList, Aid))
            {
                if (bookAuthorList.Count == 0)
                {
                    if (Author.Delete(Aid))
                    {
                        return;
                    }
                }
                else
                {
                    throw new DeleteException("Författaren kan inte tas bort då han eller hon har böcker.");
                }
            }
            throw new DoesNotExistException("Författaren som skulle tas bort hittades inte.");
        }
    }
}
