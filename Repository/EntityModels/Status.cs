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
            SqlCommand command = new SqlCommand("SELECT * from dbo.STATUS WHERE StatusId = @StatusId");
            command.Parameters.AddWithValue("StatusId", StatusId);

            List<Status> statusList;

            bool result = GetStatus(out statusList, command);

            if (statusList.Count > 0)
            {
                status = statusList[0];
            }

            return result;
        }

        public static bool GetStatus(out List<Status> statusList)
        {
            statusList = new List<Status>();

            return GetStatus(out statusList, new SqlCommand("SELECT * FROM dbo.STATUS"));
        }

        private static bool GetStatus(out List<Status> statusList, SqlCommand command)
        {
            statusList = new List<Status>();
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
                                    StatusId = myReader.GetInt32(myReader.GetOrdinal("StatusId")),
                                    StatusName = myReader.GetString(myReader.GetOrdinal("Status"))
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
