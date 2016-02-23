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
      SqlConnection connection = new SqlConnection(@"Data Source=(localdb)\Projects;Database=BibblanDatabase;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False");
      
      public bool connect()
      {
         try
         {
            connection.Open();
            SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);
            SqlDataReader myReader = null;

            myReader = myCommand.ExecuteReader();
            while(myReader.Read())
            {
               System.Diagnostics.Debug.WriteLine(myReader["PersonId"].ToString() + " " + myReader["FirstName"].ToString());
            }
         }
         catch(Exception e)
         {
            System.Diagnostics.Debug.WriteLine("ERROR: " + e.Message);
         }

         return false;
      }
   }
}
