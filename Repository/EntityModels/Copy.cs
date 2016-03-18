using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Repository.EntityModels
{
    public class Copy
    {
        public string Barcode { get; set; }
        public string Location { get; set; }
        public int StatusId {get; set;}
        public string ISBN { get; set; }
        public string Library { get; set; }

        /// <summary>
        /// Get all Copy:s matching the given ISBN.
        /// </summary>
        /// <param name="copies">A List of Copy:s. Will be set to a new instance.
        /// May be empty after execution if no records were found.</param>
        /// <param name="isbn">The ISBN as a string.</param>
        /// <returns>Returns true if no error occured.</returns>
        public static bool GetCopies(out List<Copy> copies, string isbn)
        {
            SqlCommand command = new SqlCommand("SELECT * from COPY WHERE ISBN = @ISBN");
            command.Parameters.AddWithValue("@ISBN", isbn);
            return getCopies(out copies, command);
        }

        /// <summary>
        /// Fetch a Copy from the database.
        /// </summary>
        /// <param name="copy">A variable of type Copy. Will be set to a new instance if a record was found.
        /// Will be null after execution if no record was found.</param>
        /// <param name="barcode">The Barcode of the Copy to fetch.</param>
        /// <returns>Returns true if no error occured.</returns>
        public static bool GetCopy(out Copy copy, string barcode)
        {
            SqlCommand command = new SqlCommand("SELECT * from COPY WHERE Barcode = @Barcode");
            command.Parameters.AddWithValue("@Barcode", barcode);
            var copies = new List<Copy>();
            var result = getCopies(out copies, command);
            copy = result && copies.Count > 0 ? copies[0] : null;
            return result;
        }

        /// <summary>
        /// Update a Copy or create a Copy if it doesn't exist. This means existing items will be overwritten.
        /// </summary>
        /// <param name="copy">The Copy to write to the database.</param>
        /// <returns>Returns true if one row was written and no error occured.</returns>
        static public bool Upsert(Copy copy)
        {
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("EXEC UpsertCopy @Barcode, @Location, @StatusId, @ISBN, @Library"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@Barcode", copy.Barcode);
                        command.Parameters.AddWithValue("@Location", HelperFunctions.ValueOrDBNull(copy.Location));
                        command.Parameters.AddWithValue("@StatusId", copy.StatusId);
                        command.Parameters.AddWithValue("@ISBN", HelperFunctions.ValueOrDBNull(copy.ISBN));
                        command.Parameters.AddWithValue("@Library", HelperFunctions.ValueOrDBNull(copy.Library));

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

        /// <summary>
        /// Delete a record from the database.
        /// </summary>
        /// <param name="barcode">The Barcode of the Copy to delete.</param>
        /// <returns>Returns false if delete failed or an error occured.</returns>
        public static bool Delete(string barcode)
        {
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("DELETE FROM COPY WHERE Barcode = @Barcode"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@Barcode", barcode);
                        if (command.ExecuteNonQuery() == 0)
                            return false;
                    }
                }
            }
            catch (Exception)
            {
                return false;
            }

            return true;
        }

        /// <summary>
        /// Exectute command and place records from the database in a list.
        /// </summary>
        /// <param name="copies">A List of Copy:s. Will be set to a new instance.
        /// May be empty after execution if no records were found.</param>
        /// <param name="command">The SqlCommand to execute.</param>
        /// <returns>Returns true of no errors occured.</returns>
        private static bool getCopies(out List<Copy> copies, SqlCommand command)
        {
            copies = new List<Copy>();

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
