using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.Repositories;

namespace Repository.EntityModels
{
    public class Status
    {
        public int StatusId { get; set; }
        public string StatusName { get; set; }

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

        public static bool GetStatuses(out List<Status> statusList)
        {
            return GetStatuses(out statusList, new SqlCommand("SELECT * FROM STATUS"));
        }

        private static bool GetStatuses(out List<Status> statusList, SqlCommand command)
        {
            statusList = new List<Status>();

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
