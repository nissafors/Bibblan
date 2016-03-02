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
            SqlCommand command = new SqlCommand("SELECT * from BOOK WHERE ISBN = @ISBN");
            command.Parameters.AddWithValue("@ISBN", isbn);

            List<Book> bookList;
            bool result = GetBooks(out bookList, command);

            if (result)
            {
                book = bookList[0];
            }

            return result;
        }

        public static bool GetBooks(out List<Book> bookList)
        {
            return GetBooks(out bookList, new SqlCommand("SELECT * from BOOK"));
        }

        private static bool GetBooks(out List<Book> bookList, SqlCommand command)
        {
            bookList = new List<Book>();

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
                                    bookList.Add(new Book()
                                    {
                                        ISBN = Convert.ToString(myReader["ISBN"]),
                                        Title = Convert.ToString(myReader["Title"]),
                                        PublicationInfo = Convert.ToString(myReader["PublicationInfo"]),
                                        PublicationYear = Convert.ToString(myReader["PublicationYear"]),
                                        Pages = Convert.ToInt32(myReader["Pages"]),
                                        SignId = Convert.ToInt32(myReader["SignId"])
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
