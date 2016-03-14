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

        public static bool GetBookAuthors(out List<BookAuthor> bookAuthorList, int Aid)
        {
            SqlCommand command = new SqlCommand("SELECT * from BOOK_AUTHOR WHERE Aid = @Aid");
            command.Parameters.AddWithValue("@Aid", Aid);
            return getBookAuthors(out bookAuthorList, command);
        }

        public static bool GetBookAuthors(out List<BookAuthor> bookAuthorList, string ISBN)
        {
            SqlCommand command = new SqlCommand("SELECT * from BOOK_AUTHOR WHERE ISBN = @ISBN");
            command.Parameters.AddWithValue("@ISBN", ISBN);
            return getBookAuthors(out bookAuthorList, command);
        }

        public static bool GetBookAuthors(out List<BookAuthor> bookAuthorList)
        {
            return getBookAuthors(out bookAuthorList, new SqlCommand("SELECT * from BOOK_AUTHOR"));
        }

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
