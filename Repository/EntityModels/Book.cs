﻿using System;
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
            return GetBooks(out bookList, new SqlCommand("SELECT * from BOOK ORDER BY Title ASC"));
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

        static public bool Upsert(Book book, List<int> authorIdList)
        {
            try
            {
                using (SqlConnection connection = DatabaseConnection.GetConnection())
                {
                    connection.Open();
                    // Update BOOK
                    using (SqlCommand command = new SqlCommand("EXEC UpsertBook @ISBN, @Title, @SignId, @PublicationYear, @PublicationInfo, @Pages"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@ISBN", book.ISBN);
                        command.Parameters.AddWithValue("@Title", book.Title);
                        command.Parameters.AddWithValue("@SignId", book.SignId);
                        command.Parameters.AddWithValue("@PublicationYear", book.PublicationYear);
                        command.Parameters.AddWithValue("@PublicationInfo", book.PublicationInfo);
                        command.Parameters.AddWithValue("@Pages", book.Pages);
                 
                        if (command.ExecuteNonQuery() != 1)
                        {
                            return false;
                        }
                    }

                    // Get current authorId's coupled with this isbn
                    var bookAuthors = new List<BookAuthor>();
                    var deleteAuthorIds = new List<int>();
                    var addAuthorIds = new List<int>();
                    if (BookAuthor.GetBookAuthors(out bookAuthors, book.ISBN))
                    {
                        List<int> dbIdList = bookAuthors.Select(ba => ba.Aid).ToList();
                        addAuthorIds = (from id in authorIdList where !dbIdList.Contains(id) select id).ToList();
                        deleteAuthorIds = (from id in dbIdList where !authorIdList.Contains(id) select id).ToList();
                    }

                    // Add new authors
                    foreach(int aid in addAuthorIds)
                    {
                        using (SqlCommand command = new SqlCommand("INSERT INTO BOOK_AUTHOR(ISBN, Aid) VALUES(@ISBN, @Aid)"))
                        {
                            command.Connection = connection;
                            command.Parameters.AddWithValue("@ISBN", book.ISBN);
                            command.Parameters.AddWithValue("@Aid", aid);
                            command.ExecuteNonQuery();
                        }
                    }
                    
                    // Delete "unused" author ids
                    foreach (int aid in deleteAuthorIds)
                    {
                        using (SqlCommand command = new SqlCommand("DELETE FROM BOOK_AUTHOR WHERE ISBN = @ISBN AND Aid = @Aid"))
                        {
                            command.Connection = connection;
                            command.Parameters.AddWithValue("@ISBN", book.ISBN);
                            command.Parameters.AddWithValue("@Aid", aid);
                            command.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch (Exception)
            {
                return false;
            }

            return true;
        }
    }
}
