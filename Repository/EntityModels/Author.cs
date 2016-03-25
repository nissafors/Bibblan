using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Repository.EntityModels
{
    public class Author
    {
        public int Aid { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string BirthYear { get; set; }

        /// <summary>
        /// Gets the author with the specified Aid. If there is no author
        /// with the specified Aid then author is null.
        /// </summary>
        /// <param name="author"></param>
        /// <param name="Aid"></param>
        /// <returns></returns>
        static public bool GetAuthor(out Author author, int Aid)
        {
            author = null;
            SqlCommand command = new SqlCommand("SELECT * from AUTHOR WHERE Aid = @Aid");
            command.Parameters.AddWithValue("@Aid", Aid);

            List<Author> authorList;
            bool result = GetAuthors(out authorList, command);

            if (result && authorList.Count > 0)
            {
                author = authorList[0];
            }

            return result;
        }

        /// <summary>
        /// Get a list with all authors in the database
        /// </summary>
        /// <param name="authorList"></param>
        /// <returns></returns>
        static public bool GetAuthors(out List<Author> authorList)
        {
            return GetAuthors(out authorList, new SqlCommand("SELECT * from AUTHOR ORDER BY LastName ASC"));
        }

        /// <summary>
        /// Gets a list with all authors where their first name and/or last name 
        /// matches the supplied search paramter. 
        /// </summary>
        /// <param name="authorList"></param>
        /// <param name="search"></param>
        /// <returns></returns>
        static public bool GetAuthors(out List<Author> authorList, string search)
        {
            search = HelperFunctions.SetupSearchString(search);
            SqlCommand command = new SqlCommand("SELECT * from AUTHOR WHERE COALESCE(FirstName + LastName, FirstName, LastName) LIKE @Search");
            command.Parameters.AddWithValue("@Search", search);
            return GetAuthors(out authorList, command);
        }

        /// <summary>
        /// Runs the supplied SqlCommand on the database and reads the result as an author. 
        /// Returns false if it fails.
        /// </summary>
        /// <param name="authorList"></param>
        /// <param name="command"></param>
        /// <returns></returns>
        static private bool GetAuthors(out List<Author> authorList, SqlCommand command)
        {
            authorList = new List<Author>();
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
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
                                        BirthYear = Convert.ToString(myReader["BirthYear"])
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

        /// <summary>
        /// Updates the author in the database. Returns false if it fails.
        /// </summary>
        /// <param name="author"></param>
        /// <returns></returns>
        static public bool Update(Author author)
        {
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("UPDATE AUTHOR SET FirstName=@FirstName, LastName=@LastName, BirthYear=@BirthYear WHERE Aid=@Aid"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@Aid", author.Aid);
                        command.Parameters.AddWithValue("@FirstName", HelperFunctions.ValueOrDBNull(author.FirstName));
                        command.Parameters.AddWithValue("@LastName", HelperFunctions.ValueOrDBNull(author.LastName));
                        command.Parameters.AddWithValue("@BirthYear", HelperFunctions.ValueOrDBNull(author.BirthYear));

                        if (command.ExecuteNonQuery() != 1)
                        {
                            return false;
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

        /// <summary>
        /// Inserts a new author into the database. Returns false if it fails.
        /// </summary>
        /// <param name="author"></param>
        /// <returns></returns>
        static public bool Insert(Author author)
        {
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("INSERT INTO AUTHOR (FirstName, LastName, BirthYear) VALUES (@FirstName, @LastName, @BirthYear)"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@FirstName", HelperFunctions.ValueOrDBNull(author.FirstName));
                        command.Parameters.AddWithValue("@LastName", HelperFunctions.ValueOrDBNull(author.LastName));
                        command.Parameters.AddWithValue("@BirthYear", HelperFunctions.ValueOrDBNull(author.BirthYear));

                        if (command.ExecuteNonQuery() != 1)
                        {
                            return false;
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

        /// <summary>
        /// Delete the author with the supplied Aid from the database. 
        /// Returns false if it fails.
        /// </summary>
        /// <param name="Aid"></param>
        /// <returns></returns>
        static public bool Delete(int Aid)
        {
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
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
            }
            catch(Exception)
            {
                return false;
            }

            return true;
        }
    }
}
