using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;

namespace Services.Services
{
    public class CategoryServices
    {
        static public List<Category> GetAllCategories()
        {
            List<Category> categories = new List<Category>();
            if(Category.GetCategories(out categories))
            {
                return categories;
            }
            
            return null;
        }

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

            return categoryDic;
        }
    }
}
