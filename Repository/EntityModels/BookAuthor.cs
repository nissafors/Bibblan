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

        public bool GetBookAuthors(out List<BookAuthor> bookAuthorList, int Aid, string ISBN)
        {
            bookAuthorList = new List<BookAuthor>();

            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT * from dbo.BOOKAUTHOR WHERE Aid = @Aid OR ISBN = @ISBN", connection))
                {
                    command.Parameters.AddWithValue("Aid", Aid);
                    command.Parameters.AddWithValue("ISBN", ISBN);
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

        public bool GetBookAuthors(out List<BookAuthor> bookAuthorList)
        {
            bookAuthorList = new List<BookAuthor>();
            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT * from dbo.BOOKAUTHOR", connection))
                {
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
