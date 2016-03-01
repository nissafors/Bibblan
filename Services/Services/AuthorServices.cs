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

        //public Author GetAuthorById(int id)
        //{
        //    return Mockup.Mockup.authors[id - 1];
        //}
        //
        //public static List<Author> GetAuthors(List<int> ids)
        //{
        //    var authors = new List<Author>();
        //
        //    if (ids == null)
        //        return authors;
        //
        //    foreach(Author author in Mockup.Mockup.authors)
        //    {
        //        if (ids.Contains(author.Id))
        //            authors.Add(author);
        //    }
        //
        //    return authors;
        //}
        //
        //public List<Author> GetAuthors()
        //{
        //    return Mockup.Mockup.authors;
        //}

        static public bool DeleteAuthor(string AuthorID)
        {
            return false;
        }
    }
}
