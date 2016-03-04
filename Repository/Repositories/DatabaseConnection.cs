using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Repository.Repositories
{
    public class DatabaseConnection
    {
        public static SqlConnection GetConnection() 
        {
            return new SqlConnection(@"Data Source=libinstance.ckprwkebxagl.eu-central-1.rds.amazonaws.com;Initial Catalog=BibblanDatabase;User ID=USERNAME;Password=PASSWORD");
            // SECONDARY DATABASE return new SqlConnection(@"Data Source=bibblan.database.windows.net;Initial Catalog=BibblanDatabase;Integrated Security=False;User ID=USER;Password=PASSWORD;Connect Timeout=60;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");
        }
    }
}

