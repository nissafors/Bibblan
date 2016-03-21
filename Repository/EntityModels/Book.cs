using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

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

        /// <summary>
        /// Get a book given its ISBN.
        /// </summary>
        /// <param name="book">A variable of type Book. Will be set to a new instance if a record was found, 
        /// and to null if no record was found.</param>
        /// <param name="isbn">The ISBN as a string.</param>
        /// <returns>Returns true if no error occured.</returns>
        public static bool GetBook(out Book book, string isbn)
        {
            book = null;
            SqlCommand command = new SqlCommand("SELECT * from BOOK WHERE ISBN = @ISBN");
            command.Parameters.AddWithValue("@ISBN", isbn);

            List<Book> bookList;
            bool result = getBooks(out bookList, command);

            if (result && bookList.Count > 0)
            {
                book = bookList[0];
            }

            return result;
        }

        /// <summary>
        /// Get all books in the database.
        /// </summary>
        /// <param name="bookList">A List of Book:s. Will be initialized with a new instance.
        /// May be empty after execution if no records where found.</param>
        /// <returns>Returns true if no error occured.</returns>
        public static bool GetBooks(out List<Book> bookList)
        {
            return getBooks(out bookList, new SqlCommand("SELECT * from BOOK ORDER BY Title ASC"));
        }

        /// <summary>
        /// Update a Book or create a Book in the database if it doesn't exist. This means existing items will
        /// be overwritten.
        /// </summary>
        /// <param name="copy">The Copy to write to the database.</param>
        /// <returns>Returns true if one row was written and no error occured.</returns>
        /// <exception cref="System.ArgumentException">Thrown when authorIdList is empty or given author id:s
        /// doesn't exist.</exception>
        public static bool Upsert(Book book, List<int> authorIdList)
        {
            // Are there any authorId:s and if so, do they exist? If not, the authorIdList argument was invalid.
            if (authorIdList.Count < 1)
                throw new ArgumentException("Inga författare angavs.", "authorIdList");

            foreach (int aid in authorIdList)
            {
                Author a;
                Author.GetAuthor(out a, aid);
                if (a == null)
                {
                    throw new ArgumentException("En eller flera angivna författare finns inte i databasen.", "authorIdList");
                }
            }

            // Update or create BOOK
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("EXEC UpsertBook @ISBN, @Title, @SignId, @PublicationYear, @PublicationInfo, @Pages"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@ISBN", book.ISBN);
                        command.Parameters.AddWithValue("@Title", book.Title);
                        command.Parameters.AddWithValue("@SignId", book.SignId);
                        command.Parameters.AddWithValue("@PublicationYear", HelperFunctions.ValueOrDBNull(book.PublicationYear));
                        command.Parameters.AddWithValue("@PublicationInfo", HelperFunctions.ValueOrDBNull(book.PublicationInfo));
                        command.Parameters.AddWithValue("@Pages", HelperFunctions.ValueOrDBNull(book.Pages));
                 
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

        /// <summary>
        /// Delete a book from the database given its ISBN.
        /// </summary>
        /// <param name="isbn">The ISBN as a string.</param>
        /// <returns>Returns true if no error occured.</returns>
        public static bool Delete(string isbn)
        {
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    // Delete copies
                    using (SqlCommand command = new SqlCommand("DELETE FROM COPY WHERE ISBN = @ISBN"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@ISBN", isbn);
                        command.ExecuteNonQuery();
                    }
                    
                    // Delete from BookAuthor
                    using (SqlCommand command = new SqlCommand("DELETE FROM BOOK_AUTHOR WHERE ISBN = @ISBN"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@ISBN", isbn);
                        command.ExecuteNonQuery();
                    }

                    // Delete book
                    using (SqlCommand command = new SqlCommand("DELETE FROM BOOK WHERE ISBN = @ISBN"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@ISBN", isbn);
                        command.ExecuteNonQuery();
                    }

                }
            }
            catch (Exception)
            {
                return false;
            }

            return true;
        }

        /// <summary>
        /// Get books and related authors given a search string.
        /// </summary>
        /// <param name="bookList">A List of Book:s. Will be set to a new instance.
        /// May be empty after execution if no records where found.</param>
        /// <param name="isbnAuthorList">A list of Tuple:s consisting of two strings. For each record returned the first
        /// string in the tuple will be the full name of the author and the second string will be the ISBN of the
        /// relevant book. Will be set to a new instance. May be empty after execution if no records where found.</param>
        /// <param name="search">The search string.</param>
        /// <returns>Returns true if no errors occured.</returns>
        public static bool SearchBook(out List<Book> bookList, out List<Tuple<string, string>> isbnAuthorList, string search)
        {
            string modifiedSearch = HelperFunctions.SetupSearchString(search);

            bookList = new List<Book>();
            isbnAuthorList = new List<Tuple<string, string>>();

            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    string commandString = "SELECT " +
                                           "BOOK.ISBN AS ISBN, " +
                                           "BOOK.Title AS Title, " +
                                           "Book.Pages AS Pages, " +
                                           "BOOK.PublicationInfo AS PublicationInfo, " +
                                           "BOOK.PublicationYear AS PublicationYear, " +
                                           "BOOK.SignId AS SignId, " +
                                           "COALESCE(AUTHOR.LastName + ' ' + AUTHOR.FirstName, AUTHOR.LastName, AUTHOR.FirstName) AS Name " +
                                           "FROM BOOK_AUTHOR " +
                                           "INNER JOIN BOOK ON BOOK_AUTHOR.ISBN = BOOK.ISBN " +
                                           "INNER JOIN AUTHOR ON BOOK_AUTHOR.AID = AUTHOR.AID " +
                                           "WHERE Title + COALESCE(FirstName, '') + COALESCE(LastName, '') LIKE @ModifiedSearch OR " +
                                           "WHERE Title + COALESCE(LastName, '') + COALESCE(FirstName, '') LIKE @ModifiedSearch OR " +
                                           "WHERE COALESCE(LastName, '') + Title + COALESCE(FirstName, '') LIKE @ModifiedSearch OR " +
                                           "WHERE COALESCE(LastName, '') + COALESCE(FirstName, '') + Title LIKE @ModifiedSearch OR " +
                                           "WHERE COALESCE(FirstName, '') + COALESCE(LastName, '') + Title LIKE @ModifiedSearch OR " +
                                           "WHERE COALESCE(FirstName, '') + Title + COALESCE(LastName, '') LIKE @ModifiedSearch OR " +
                                           "BOOK.ISBN = @Search";
                    using (SqlCommand command = new SqlCommand(commandString, connection))
                    {
                        command.Parameters.AddWithValue("@Search", search);
                        command.Parameters.AddWithValue("@ModifiedSearch", modifiedSearch);

                        using (SqlDataReader myReader = command.ExecuteReader())
                        {
                            if (myReader != null)
                            {
                                while (myReader.Read())
                                {
                                    string ISBN = Convert.ToString(myReader["ISBN"]);
                                    if(!bookList.Exists(x => x.ISBN == ISBN))
                                    {
                                        bookList.Add(new Book()
                                        {
                                            ISBN = ISBN,
                                            Title = Convert.ToString(myReader["Title"]),
                                            PublicationInfo = Convert.ToString(myReader["PublicationInfo"]),
                                            PublicationYear = Convert.ToString(myReader["PublicationYear"]),
                                            Pages = Convert.ToInt32(myReader["Pages"]),
                                            SignId = Convert.ToInt32(myReader["SignId"])
                                        });
                                    }
                                    isbnAuthorList.Add(new Tuple<string,string>(Convert.ToString(myReader["Name"]), ISBN));
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
            catch (Exception)
            {
                return false;
            }

            return true;
        }

        /// <summary>
        /// Fetch records from the database and place them in a list.
        /// </summary>
        /// <param name="bookList">A List of Book:s. Will be initialized with a new instance.
        /// May be empty after execution if no records where found.</param>
        /// <param name="command">An SqlCommand to execute.</param>
        /// <returns>True if no error occured.</returns>
        private static bool getBooks(out List<Book> bookList, SqlCommand command)
        {
            bookList = new List<Book>();

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
            catch (Exception)
            {
                return false;
            }

            return true;
        }
    }
}
