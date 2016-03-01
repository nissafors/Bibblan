using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.Repositories;

namespace Repository.EntityModels
{
    public class Category
    {
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
        public int Period { get; set; }
        public int PenaltyPerDay { get; set; }

        public static bool GetCategories(out Category category, int categoryId)
        {
            category = null;
            SqlCommand command = new SqlCommand("SELECT * from dbo.CATEGORY WHERE CategoryId = @CategoryId");
            command.Parameters.AddWithValue("CategoryId", categoryId);

            List<Category> categoryList;

            bool result = GetCategories(out categoryList, command);

            if (categoryList.Count > 0)
            {
                category = categoryList[0];
            }

            return result;
        }

        public static bool GetCategories(out List<Category> categoryList)
        {
            categoryList = new List<Category>();

            return GetCategories(out categoryList, new SqlCommand("SELECT * FROM dbo.CATEGORY"));
        }

        private static bool GetCategories(out List<Category> categoryList, SqlCommand command)
        {
            categoryList = new List<Category>();
            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                using (command)
                {
                    command.Connection = connection;
                    using (SqlDataReader myReader = command.ExecuteReader())
                    {
                        if (myReader != null)
                        {
                            while (myReader.Read())
                            {
                                categoryList.Add(new Category()
                                {
                                    CategoryName = myReader.GetString(myReader.GetOrdinal("Category")),
                                    CategoryId = myReader.GetInt32(myReader.GetOrdinal("CategoryId")),
                                    PenaltyPerDay = myReader.GetInt32(myReader.GetOrdinal("PenaltyPerDay")),
                                    Period = myReader.GetInt32(myReader.GetOrdinal("Period"))
                                });
                            }
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
            }
            return true;
        }
    }
}
