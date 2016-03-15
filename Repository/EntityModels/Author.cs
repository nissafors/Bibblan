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
            SqlCommand command = new SqlCommand("SELECT * from AUTHOR WHERE Aid = @Aid");
            command.Parameters.AddWithValue("@Aid", Aid);

            List<Author> authorList;
            bool result = GetAuthors(out authorList, command);

            if (result)
            {
                author = authorList[0];
            }

            return result;
        }

        static public bool GetAuthors(out List<Author> authorList)
        {
            return GetAuthors(out authorList, new SqlCommand("SELECT * from AUTHOR"));
        }

        static public bool GetAuthors(out List<Author> authorList, string search)
        {
            search = HelperFunctions.SetupSearchString(search);
            SqlCommand command = new SqlCommand("SELECT * from AUTHOR WHERE COALESCE(FirstName + LastName, FirstName, LastName) LIKE @Search");
            command.Parameters.AddWithValue("@Search", search);
            return GetAuthors(out authorList, command);
        }

        static private bool GetAuthors(out List<Author> authorList, SqlCommand command)
        {
            authorList = new List<Author>();

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
                                authorList.Add(new Author()
                                {
                                    Aid = Convert.ToInt32(myReader["Aid"]),
                                    FirstName = Convert.ToString(myReader["FirstName"]),
                                    LastName = Convert.ToString(myReader["LastName"]),
                                    BirthYear = Convert.ToString(myReader["Birthyear"])
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

        static public bool Update(Author author)
        {
            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("UPDATE AUTHOR SET FirstName=@FirstName, LastName=@LastName, BirthYear=@BirthYear WHERE Aid=@Aid"))
                {
                    command.Connection = connection;
                    command.Parameters.AddWithValue("@Aid", author.Aid);
                    command.Parameters.AddWithValue("@FirstName", DBNullHelper.ValueOrDBNull(author.FirstName));
                    command.Parameters.AddWithValue("@LastName", DBNullHelper.ValueOrDBNull(author.LastName));
                    command.Parameters.AddWithValue("@BirthYear", DBNullHelper.ValueOrDBNull(author.BirthYear));

                    if (command.ExecuteNonQuery() != 1)
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        static public bool Insert(Author author)
        {
            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("INSERT INTO AUTHOR (FirstName, LastName, BirthYear) VALUES (@FirstName, @LastName, @BirthYear)"))
                {
                    command.Connection = connection;
                    command.Parameters.AddWithValue("@FirstName", DBNullHelper.ValueOrDBNull(author.FirstName));
                    command.Parameters.AddWithValue("@LastName", DBNullHelper.ValueOrDBNull(author.LastName));
                    command.Parameters.AddWithValue("@BirthYear", DBNullHelper.ValueOrDBNull(author.BirthYear));

                    if (command.ExecuteNonQuery() != 1)
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        static public bool Delete(int Aid)
        {
            using (SqlConnection connection = DatabaseConnection.GetConnection())
            {
                connection.Open();
                // Delete author
                using (SqlCommand command = new SqlCommand("DELETE FROM AUTHOR WHERE Aid = @Aid", connection))
                {
                    command.Parameters.AddWithValue("@Aid", Aid);

                    if (command.ExecuteNonQuery() == 0)
                    {
                        // Did not delete anything
                        return false;
                    }
                }
            }
            return true;
        }
    }
}
