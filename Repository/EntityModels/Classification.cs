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

        public static bool GetClassifications(out Classification classification, int SignId)
        {
            classification = null;
            SqlCommand command = new SqlCommand("SELECT * from dbo.CLASSIFICATION WHERE SignId = @SignId");
            command.Parameters.AddWithValue("SignId", SignId);

            List<Classification> classificationList;

            bool result = GetClassifications(out classificationList, command);

            if (classificationList.Count > 0)
            {
                classification = classificationList[0];
            }

            return result;
        }

        public static bool GetClassifications(out List<Classification> classificationList)
        {
            classificationList = new List<Classification>();

            return GetClassifications(out classificationList, new SqlCommand("SELECT * FROM dbo.CLASSIFICATION"));
        }

        private static bool GetClassifications(out List<Classification> classificationList, SqlCommand command)
        {
            classificationList = new List<Classification>();
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
                                    Signum = myReader["Signum"].ToString(),
                                    Description = myReader["Description"].ToString()
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
