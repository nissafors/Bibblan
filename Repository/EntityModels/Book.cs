using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.Repositories;

namespace Repository.EntityModels
{
    public class Book
    {
        public string ISBN { get; set; }
        public string Title { get; set; }
        public int SignId { get; set; }
        public string PublicationYear { get; set; }
        public string PublicationInfo { get; set; }
        public int Pages { get; set; }

        public static bool GetBook(out Book book, string isbn)
        {
            book = null;

            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT * from dbo.BOOK WHERE ISBN = @ISBN", connection))
                {
                    command.Parameters.AddWithValue("ISBN", isbn);
                    using (SqlDataReader myReader = command.ExecuteReader())
                    {
                        if (myReader != null)
                        {
                            myReader.Read();
                            book = new Book()
                            {
                                ISBN = myReader.GetString(myReader.GetOrdinal("ISBN")),
                                Title = myReader.GetString(myReader.GetOrdinal("Title")),
                                PublicationInfo = myReader.GetString(myReader.GetOrdinal("PublicationInfo")),
                                PublicationYear = myReader.GetString(myReader.GetOrdinal("PublicationYear")),
                                Pages = myReader.GetInt32(myReader.GetOrdinal("Pages"))
                            };
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

        public static bool GetBooks(out List<Book> bookList)
        {
            bookList = new List<Book>();
            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT * from dbo.BOOK", connection))
                {
                    using (SqlDataReader myReader = command.ExecuteReader())
                    {
                        if (myReader != null)
                        {
                            while (myReader.Read())
                            {
                                bookList.Add(new Book()
                                {
                                    ISBN = myReader.GetString(myReader.GetOrdinal("ISBN")),
                                    Title = myReader.GetString(myReader.GetOrdinal("Title")),
                                    PublicationInfo = myReader.GetString(myReader.GetOrdinal("PublicationInfo")),
                                    PublicationYear = myReader.GetString(myReader.GetOrdinal("PublicationYear")),
                                    Pages = myReader.GetInt32(myReader.GetOrdinal("Pages"))
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
