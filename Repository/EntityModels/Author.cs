﻿using System;
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

            if(result)
            {
                author = authorList[0];
            }

            return result;
        }

        static public bool GetAuthors(out List<Author> authorList)
        {
            return GetAuthors(out authorList, new SqlCommand("SELECT * from AUTHOR"));
        }

        static private bool GetAuthors(out List<Author> authorList, SqlCommand command)
        {
            authorList = new List<Author>();

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
            }
            catch(Exception)
            {
                return false;
            }

            return true;
        }

        static public bool Upsert(Author author)
        {
            try
            {
                using (SqlConnection connection = DatabaseConnection.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("EXEC UpsertAuthor @Aid, @FirstName, @LastName, @BirthYear"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@Aid", author.Aid);
                        command.Parameters.AddWithValue("@FirstName", author.FirstName);
                        command.Parameters.AddWithValue("@LastName", author.LastName);
                        command.Parameters.AddWithValue("@BirthYear", author.BirthYear);

                        if(command.ExecuteNonQuery() != 1)
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
    }
}
