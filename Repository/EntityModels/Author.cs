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

            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT * from dbo.AUTHOR WHERE Aid = @Aid", connection))
                {
                    command.Parameters.AddWithValue("Aid", Aid);
                    using(SqlDataReader myReader = command.ExecuteReader())
                    {
                        if (myReader != null)
                        {
                            myReader.Read();
                            author = new Author()
                            {
                                Aid = myReader.GetInt32(myReader.GetOrdinal("Aid")),
                                FirstName = myReader.GetString(myReader.GetOrdinal("FirstName")),
                                LastName = myReader.GetString(myReader.GetOrdinal("LastName")),
                                BirthYear = myReader.GetString(myReader.GetOrdinal("Birthyear"))
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

        static public bool GetAuthor(out List<Author> authorList)
        {
            authorList = new List<Author>();

            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT * from dbo.AUTHOR", connection))
                {
                    using (SqlDataReader myReader = command.ExecuteReader())
                    {
                        if (myReader != null)
                        {
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
