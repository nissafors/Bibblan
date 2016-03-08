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
        /*
        static public Category GetCategory(int id)
        {
            return Mockup.Mockup.categories[0];
        }
        */
    }
}
