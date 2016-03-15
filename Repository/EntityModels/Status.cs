using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Repository.EntityModels
{
    public class Status
    {
        public int StatusId { get; set; }
        public string StatusName { get; set; }

        /// <summary>
        /// Gets the status with the specified StatusId. If there is no status
        /// with the specified StatusId then status is null. Returns false if it fails.
        /// </summary>
        /// <param name="status"></param>
        /// <param name="StatusId"></param>
        /// <returns></returns>
        public static bool GetStatus(out Status status, int StatusId)
        {
            status = null;
            SqlCommand command = new SqlCommand("SELECT * from STATUS WHERE StatusId = @StatusId");
            command.Parameters.AddWithValue("@StatusId", StatusId);

            List<Status> statusList;

            bool result = GetStatuses(out statusList, command);

            if (statusList.Count > 0)
            {
                status = statusList[0];
            }

            return result;
        }

        /// <summary>
        /// Gets all statuses in the database. Returns false if it fails.
        /// </summary>
        /// <param name="statusList"></param>
        /// <returns></returns>
        public static bool GetStatuses(out List<Status> statusList)
        {
            return GetStatuses(out statusList, new SqlCommand("SELECT * FROM STATUS"));
        }

        /// <summary>
        /// Runs the supplied SqlCommand on the database and reads the result as a status. 
        /// Returns false if it fails.
        /// </summary>
        /// <param name="statusList"></param>
        /// <param name="command"></param>
        /// <returns></returns>
        private static bool GetStatuses(out List<Status> statusList, SqlCommand command)
        {
            statusList = new List<Status>();

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
                                    statusList.Add(new Status()
                                    {
                                        StatusId = Convert.ToInt32(myReader["StatusId"]),
                                        StatusName = Convert.ToString(myReader["Status"])
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
