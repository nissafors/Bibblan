using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.Repositories;

namespace Repository.EntityModels
{
    public class Copy
    {
        public string Barcode { get; set; }
        public string Location { get; set; }
        public int StatusId {get; set;}
        public string ISBN { get; set; }
        public string Library { get; set; }

        public static bool GetCopies(out List<Copy> copies, string isbn)
        {
            SqlCommand command = new SqlCommand("SELECT * from COPY WHERE ISBN = @ISBN");
            command.Parameters.AddWithValue("@ISBN", isbn);
            return getCopies(out copies, command);
        }

        private static bool getCopies(out List<Copy> copies, SqlCommand command)
        {
            copies = new List<Copy>();

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
                                    copies.Add(new Copy()
                                    {
                                        Barcode = Convert.ToString(myReader["Barcode"]),
                                        ISBN = Convert.ToString(myReader["ISBN"]),
                                        Location = Convert.ToString(myReader["Location"]),
                                        Library = Convert.ToString(myReader["Library"]),
                                        StatusId = Convert.ToInt32(myReader["StatusId"])
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
