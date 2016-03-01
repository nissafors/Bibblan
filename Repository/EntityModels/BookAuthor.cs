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
            SqlCommand command = new SqlCommand("SELECT * from dbo.BOOKAUTHOR WHERE Aid = @Aid");
            command.Parameters.AddWithValue("Aid", Aid);
            return getBookAuthors(out bookAuthorList, command);
        }

        public static bool GetBookAuthors(out List<BookAuthor> bookAuthorList, string ISBN)
        {
            SqlCommand command = new SqlCommand("SELECT * from dbo.BOOKAUTHOR WHERE ISBN = @ISBN");
            command.Parameters.AddWithValue("ISBN", ISBN);
            return getBookAuthors(out bookAuthorList, command);
        }

        public static bool GetBookAuthors(out List<BookAuthor> bookAuthorList)
        {
            SqlCommand command = new SqlCommand("SELECT * from dbo.BOOKAUTHOR");
            return getBookAuthors(out bookAuthorList, command);
        }

        private static bool getBookAuthors(out List<BookAuthor> bookAuthorList, SqlCommand command)
        {
            bookAuthorList = new List<BookAuthor>();

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
                                    Aid = myReader.GetInt32(myReader.GetOrdinal("Aid")),
                                    ISBN = myReader.GetString(myReader.GetOrdinal("ISBN")),
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
            return true;
        }
    }
}
