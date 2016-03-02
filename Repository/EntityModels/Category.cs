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
            SqlCommand command = new SqlCommand("SELECT * from CATEGORY WHERE CategoryId = @CategoryId");
            command.Parameters.AddWithValue("@CategoryId", categoryId);

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
            return GetCategories(out categoryList, new SqlCommand("SELECT * FROM CATEGORY"));
        }

        private static bool GetCategories(out List<Category> categoryList, SqlCommand command)
        {
            categoryList = new List<Category>();

            try
            {
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
                                        CategoryName = Convert.ToString(myReader["Category"]),
                                        CategoryId = Convert.ToInt32(myReader["CategoryId"]),
                                        PenaltyPerDay = Convert.ToInt32(myReader["PenaltyPerDay"]),
                                        Period = Convert.ToInt32(myReader["Period"])
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
            }
            catch(Exception)
            {
                return false;
            }

            return true;
        }
    }
}
