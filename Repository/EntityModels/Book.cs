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
            var connection = DatabaseConnection.GetConnection();
            SqlDataReader myReader = null;
            book = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BOOK WHERE ISBN = " + isbn, connection);

                myReader = myCommand.ExecuteReader();
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
