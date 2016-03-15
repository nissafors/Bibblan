using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.Repositories;

namespace Repository.EntityModels
{
    public class Classification
    {
        public int SignId { get; set; }
        public string Signum { get; set; }
        public string Description { get; set; }

        /// <summary>
        /// Gets the classification with the specified SignId. If there is no classification
        /// with the specified SignId then classification is null. Returns false if it fails.
        /// </summary>
        /// <param name="classification"></param>
        /// <param name="SignId"></param>
        /// <returns></returns>
        public static bool GetClassification(out Classification classification, int SignId)
        {
            classification = null;
            SqlCommand command = new SqlCommand("SELECT * from CLASSIFICATION WHERE SignId = 1");
            command.Parameters.AddWithValue("@SignId", SignId.ToString());

            List<Classification> classificationList;

            bool result = GetClassifications(out classificationList, command);

            if (result && classificationList.Count > 0)
            {
                classification = classificationList[0];
            }

            return result;
        }

        /// <summary>
        /// Gets all classifications in the database. Returns false if it fails.
        /// </summary>
        /// <param name="classificationList"></param>
        /// <returns></returns>
        public static bool GetClassifications(out List<Classification> classificationList)
        {
            return GetClassifications(out classificationList, new SqlCommand("SELECT * FROM CLASSIFICATION"));
        }

        /// <summary>
        /// Runs the supplied SqlCommand on the database and reads the result as a classification. 
        /// Returns false if it fails.
        /// </summary>
        /// <param name="classificationList"></param>
        /// <param name="command"></param>
        /// <returns></returns>
        private static bool GetClassifications(out List<Classification> classificationList, SqlCommand command)
        {
            classificationList = new List<Classification>();

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
                                    classificationList.Add(new Classification()
                                    {
                                        SignId = Convert.ToInt32(myReader["SignId"]),
                                        Signum = Convert.ToString(myReader["Signum"]),
                                        Description = Convert.ToString(myReader["Description"])
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
