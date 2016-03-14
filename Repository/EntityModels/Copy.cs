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

        public static bool GetCopy(out Copy copy, string barCode)
        {
            SqlCommand command = new SqlCommand("SELECT * from COPY WHERE Barcode = @Barcode");
            command.Parameters.AddWithValue("@Barcode", barCode);
            var copies = new List<Copy>();
            var result = getCopies(out copies, command);
            copy = result && copies.Count > 0 ? copies[0] : null;
            return result;
        }

        static public bool Upsert(Copy copy)
        {
            try
            {
                using (SqlConnection connection = DatabaseConnection.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("EXEC UpsertCopy @Barcode, @Location, @StatusId, @ISBN, @Library"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@Barcode", copy.Barcode);
                        command.Parameters.AddWithValue("@Location", DBNullHelper.ValueOrDBNull(copy.Location));
                        command.Parameters.AddWithValue("@StatusId", copy.StatusId);
                        command.Parameters.AddWithValue("@ISBN", DBNullHelper.ValueOrDBNull(copy.ISBN));
                        command.Parameters.AddWithValue("@Library", DBNullHelper.ValueOrDBNull(copy.Library));

                        if (command.ExecuteNonQuery() != 1)
                        {
                            return false;
                        }
                    }

                }
            }
            catch (Exception)
            {
                return false;
            }

            return true;
        }

        public static bool Delete(string barcode)
        {
            try
            {
                using (SqlConnection connection = DatabaseConnection.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("DELETE FROM COPY WHERE Barcode = @Barcode"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@Barcode", barcode);
                        command.ExecuteNonQuery();
                    }

                }
            }
            catch (Exception)
            {
                return false;
            }

            return true;
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
