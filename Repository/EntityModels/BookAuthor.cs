using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.Repositories;

namespace Repository.EntityModels
{
    public class BookAuthor
    {
        public string ISBN { get; set; }
        public int Aid { get; set; }

        /// <summary>
        /// Get all BookAuthor:s matching the given author id.
        /// </summary>
        /// <param name="bookAuthorList">A List of BookAuthor:s.  Will be set to a new instance.
        /// May be empty after execution if no records where found.</param>
        /// <param name="Aid">The author id as an int.</param>
        /// <returns>Returns true if no errors occured.</returns>
        public static bool GetBookAuthors(out List<BookAuthor> bookAuthorList, int Aid)
        {
            SqlCommand command = new SqlCommand("SELECT * from BOOK_AUTHOR WHERE Aid = @Aid");
            command.Parameters.AddWithValue("@Aid", Aid);
            return getBookAuthors(out bookAuthorList, command);
        }

        /// <summary>
        /// Get all BookAuthor:s matching the given ISBN.
        /// </summary>
        /// <param name="bookAuthorList">A List of BookAuthor:s.  Will be set to a new instance.
        /// May be empty after execution if no records where found.</param>
        /// <param name="ISBN">The ISBN as a string.</param>
        /// <returns>Returns true if no errors occured.</returns>
        public static bool GetBookAuthors(out List<BookAuthor> bookAuthorList, string ISBN)
        {
            SqlCommand command = new SqlCommand("SELECT * from BOOK_AUTHOR WHERE ISBN = @ISBN");
            command.Parameters.AddWithValue("@ISBN", ISBN);
            return getBookAuthors(out bookAuthorList, command);
        }

        /// <summary>
        /// Gett all BookAuthor:s in the database.
        /// </summary>
        /// <param name="bookAuthorList">A List of BookAuthor:s.  Will be set to a new instance.
        /// May be empty after execution if no records where found.</param>
        /// <returns>Returns true if no errors occured.</returns>
        public static bool GetBookAuthors(out List<BookAuthor> bookAuthorList)
        {
            return getBookAuthors(out bookAuthorList, new SqlCommand("SELECT * from BOOK_AUTHOR"));
        }

        /// <summary>
        /// Excecutes command and places the result in a list.
        /// </summary>
        /// <param name="bookAuthorList">A list of BookAuthors. Will be set to a new instance.
        /// May be empty after execution if no records where found.</param>
        /// <param name="command">The SqlCommand to execute.</param>
        /// <returns>Returns true if no errors occured.</returns>
        private static bool getBookAuthors(out List<BookAuthor> bookAuthorList, SqlCommand command)
        {
            bookAuthorList = new List<BookAuthor>();
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
                                    bookAuthorList.Add(new BookAuthor()
                                    {
                                        Aid = Convert.ToInt32(myReader["Aid"]),
                                        ISBN = Convert.ToString(myReader["ISBN"])
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
