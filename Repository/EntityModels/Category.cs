using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Repository.EntityModels
{
    public class Category
    {
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
        public int Period { get; set; }
        public int PenaltyPerDay { get; set; }

        /// <summary>
        /// Gets the category with the specified CategoryId. If there is no category
        /// with the specified CategoryId then category is null. Returns false if it fails.
        /// </summary>
        /// <param name="category"></param>
        /// <param name="categoryId"></param>
        /// <returns></returns>
        public static bool GetCategory(out Category category, int categoryId)
        {
            category = null;
            SqlCommand command = new SqlCommand("SELECT * from CATEGORY WHERE CategoryId = @CategoryId");
            command.Parameters.AddWithValue("@CategoryId", categoryId);

            List<Category> categoryList;

            bool result = GetCategories(out categoryList, command);

            if (result && categoryList.Count > 0)
            {
                category = categoryList[0];
            }

            return result;
        }

        /// <summary>
        /// Gets all categories in the database. Returns false if it fails.
        /// </summary>
        /// <param name="categoryList"></param>
        /// <returns></returns>
        public static bool GetCategories(out List<Category> categoryList)
        {
            return GetCategories(out categoryList, new SqlCommand("SELECT * FROM CATEGORY"));
        }

        /// <summary>
        /// Runs the supplied SqlCommand on the database and reads the result as a category. 
        /// Returns false if it fails.
        /// </summary>
        /// <param name="categoryList"></param>
        /// <param name="command"></param>
        /// <returns></returns>
        private static bool GetCategories(out List<Category> categoryList, SqlCommand command)
        {
            categoryList = new List<Category>();

            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
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
                                        PenaltyPerDay = Convert.ToInt32(myReader["Penaltyperday"]),
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
