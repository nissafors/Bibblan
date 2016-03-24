using Repository.EntityModels;
using Services.Exceptions;
using System.Collections.Generic;

namespace Services.Services
{
    public class CategoryServices
    {
        /// <summary>
        /// Return category ids and corresponding names.
        /// </summary>
        /// <returns>Returns a dictionary with ids as keys and names as strings.</returns>
        /// <exception cref="Services.Exceptions.DataAccessException">
        /// Thrown when an error occurs in the data access layer.</exception>
        public static Dictionary<int, string> GetCategoriesAsDictionary()
        {
            Dictionary<int, string> categoryDic = new Dictionary<int, string>();
            List<Category> categoryList;

            if (Category.GetCategories(out categoryList))
            {
                foreach (Category category in categoryList)
                {
                    categoryDic.Add(category.CategoryId, category.CategoryName);
                }
            }
            else
                throw new DataAccessException("Oväntat fel när kategorier skulle hämtas.");

            return categoryDic;
        }
    }
}
