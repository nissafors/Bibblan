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
        SqlConnection connection = new SqlConnection(@"Data Source=(localdb)\Projects;Initial Catalog=BibblanDatabase;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False");

        public static SqlConnection GetConnection() {
            return new SqlConnection(@"Data Source=(localdb)\Projects;Initial Catalog=BibblanDatabase;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False");
        }
    }
}
