using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.Repositories;

namespace Repository.EntityModels
{
    public class Author
    {
        public int Aid { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string BirthYear { get; set; }

        static public bool GetAuthor(out Author author, int Aid)
        {
            author = null;
            SqlDataReader myReader = null;
            SqlConnection connection = DatabaseConnection.GetConnection();

            try
            {
                string sqlString = "SELECT * from dbo.AUTHOR WHERE Aid = @Aid";
                SqlCommand command = new SqlCommand(sqlString);
                command.Parameters.AddWithValue("Aid", Aid);

                connection.Open();

                myReader = command.ExecuteReader();
                myReader.Read();
                author = new Author()
                {
                    Aid = myReader.GetInt32(myReader.GetOrdinal("Aid")),
                    FirstName = myReader.GetString(myReader.GetOrdinal("FirstName")),
                    LastName = myReader.GetString(myReader.GetOrdinal("LastName")),
                    BirthYear = myReader.GetString(myReader.GetOrdinal("Birthyear")),
                };
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("ERROR: " + e.Message);
                return false;
            }
            finally
            {
                if (myReader != null)
                {
                    myReader.Close();
                }
            }

            return true;
        }

        static public bool GetAuthors(out List<Author> authorList)
        {
            authorList = new List<Author>();
            SqlDataReader myReader = null;
            SqlConnection connection = DatabaseConnection.GetConnection();

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.AUTHOR", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    authorList.Add(new Author()
                    {
                        Aid = myReader.GetInt32(myReader.GetOrdinal("Aid")),
                        FirstName = myReader.GetString(myReader.GetOrdinal("FirstName")),
                        LastName = myReader.GetString(myReader.GetOrdinal("LastName")),
                        BirthYear = myReader.GetString(myReader.GetOrdinal("Birthyear")),
                    });
                }
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
