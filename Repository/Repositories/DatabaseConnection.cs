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

        

        public bool GetClassifications(out List<Classification> classificationList)
        {
            classificationList = new List<Classification>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    classificationList.Add(new Classification()
                    {
                        SignId = myReader.GetInt32(myReader.GetOrdinal("SignId")),
                        Signum = myReader.GetString(myReader.GetOrdinal("Signum")),
                        Description = myReader.GetString(myReader.GetOrdinal("Description"))
                    });
                }
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("ERROR: " + e.Message);
                return false;
            }
            finally
            {
                myReader.Close();
            }

            return true;
        }

        public bool GetCopies(out List<Copy> copiesList)
        {
            copiesList = new List<Copy>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    copiesList.Add(new Copy()
                    {
                        Barcode = myReader.GetString(myReader.GetOrdinal("Barcode")),
                        ISBN = myReader.GetString(myReader.GetOrdinal("ISBN")),
                        Location = myReader.GetString(myReader.GetOrdinal("Location")),
                        Library = myReader.GetString(myReader.GetOrdinal("Library")),
                        StatusId = myReader.GetInt32(myReader.GetOrdinal("StatusId"))
                    });
                }
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("ERROR: " + e.Message);
                return false;
            }
            finally
            {
                myReader.Close();
            }

            return true;
        }

        public bool GetCopies(out List<Copy> copiesList)
        {
            copiesList = new List<Copy>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    copiesList.Add(new Copy()
                    {
                        Barcode = myReader.GetString(myReader.GetOrdinal("Barcode")),
                        ISBN = myReader.GetString(myReader.GetOrdinal("ISBN")),
                        Location = myReader.GetString(myReader.GetOrdinal("Location")),
                        Library = myReader.GetString(myReader.GetOrdinal("Library")),
                        StatusId = myReader.GetInt32(myReader.GetOrdinal("StatusId"))
                    });
                }
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("ERROR: " + e.Message);
                return false;
            }
            finally
            {
                myReader.Close();
            }

            return true;
        }

        public bool GetStatus(out List<Status> statusList)
        {
            statusList = new List<Status>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    statusList.Add(new Status()
                    {
                        StatusId = myReader.GetInt32(myReader.GetOrdinal("StatusId")),
                        StatusName = myReader.GetString(myReader.GetOrdinal("Status"))
                    });
                }
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("ERROR: " + e.Message);
                return false;
            }
            finally
            {
                myReader.Close();
            }

            return true;
        }
    }
}
