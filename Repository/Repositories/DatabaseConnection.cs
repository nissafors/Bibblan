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
        }
    }
}