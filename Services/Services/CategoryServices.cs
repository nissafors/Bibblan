using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using System.Web.Mvc;

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

        static public SelectList CategoriesAsSelectList()
        {
            List<Category> categoryList = GetAllCategories();
            return new SelectList(categoryList.OrderBy(x => x.CategoryName), "CategoryId", "CategoryName");
        }
    }
}
