using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.EntityModels;

namespace Repository.Repositories
{
    public class DatabaseConnection
    {
        static SqlConnection connection = new SqlConnection(@"Data Source=(localdb)\Projects;Initial Catalog=BibblanDatabase;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False");

        public static SqlConnection GetConnection() {
            return new SqlConnection(@"Data Source=(localdb)\Projects;Initial Catalog=BibblanDatabase;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False");
        }

        public bool GetAuthors(out List<Author> authorList)
        {
            authorList = new List<Author>();
            SqlDataReader myReader = null;

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


        public bool GetBooks(out List<Book> bookList)
        {
            bookList = new List<Book>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BOOK", connection);

                myReader = myCommand.ExecuteReader();
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

        public bool GetBookAuthors(out List<BookAuthor> bookAuthorList)
        {
            bookAuthorList = new List<BookAuthor>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);
                

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    bookAuthorList.Add(new BookAuthor()
                    {
                        Aid = myReader.GetInt32(myReader.GetOrdinal("Aid")),
                        ISBN = myReader.GetString(myReader.GetOrdinal("ISBN")),
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

        public bool GetBorrows(out List<Borrow> borrowList)
        {
            borrowList = new List<Borrow>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    borrowList.Add(new Borrow()
                    {
                        Barcode = myReader.GetString(myReader.GetOrdinal("Barcode")),
                        PersonId = myReader.GetString(myReader.GetOrdinal("PersonId")),
                        BorrowDate = myReader.GetDateTime(myReader.GetOrdinal("BorrowDate")),
                        ReturnDate = myReader.GetDateTime(myReader.GetOrdinal("ReturnDate")),
                        ToBeReturnedDate = myReader.GetDateTime(myReader.GetOrdinal("ToBeReturnedDate"))
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

        public bool GetBorrowers(out List<Borrower> borrowerList)
        {
            borrowerList = new List<Borrower>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    borrowerList.Add(new Borrower()
                    {
                        PersonId = myReader.GetString(myReader.GetOrdinal("PersonId")),
                        FirstName = myReader.GetString(myReader.GetOrdinal("FirstName")),
                        LastName = myReader.GetString(myReader.GetOrdinal("LastName")),
                        Adress = myReader.GetString(myReader.GetOrdinal("Adress")),
                        CategoryId = myReader.GetInt32(myReader.GetOrdinal("CategoryId")),
                        TelNo = myReader.GetString(myReader.GetOrdinal("TelNo"))
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

        public bool GetCategories(out List<Category> categoryList)
        {
            categoryList = new List<Category>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    categoryList.Add(new Category()
                    {
                        CategoryName = myReader.GetString(myReader.GetOrdinal("Category")),
                        CategoryId = myReader.GetInt32(myReader.GetOrdinal("CategoryId")),
                        PenaltyPerDay = myReader.GetInt32(myReader.GetOrdinal("PenaltyPerDay")),
                        Period = myReader.GetInt32(myReader.GetOrdinal("Period"))
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

        public bool GetClassifications(out List<Classification> classificationList)
        {
            classificationList = new List<Classification>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    classificationList.Add(new Classification()
                    {
                        SignId = myReader.GetInt32(myReader.GetOrdinal("SignId")),
                        Signum = myReader.GetString(myReader.GetOrdinal("Signum")),
                        Description = myReader.GetString(myReader.GetOrdinal("Description"))
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

        public bool GetCopies(out List<Copy> copiesList)
        {
            copiesList = new List<Copy>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    copiesList.Add(new Copy()
                    {
                        Barcode = myReader.GetString(myReader.GetOrdinal("Barcode")),
                        ISBN = myReader.GetString(myReader.GetOrdinal("ISBN")),
                        Location = myReader.GetString(myReader.GetOrdinal("Location")),
                        Library = myReader.GetString(myReader.GetOrdinal("Library")),
                        StatusId = myReader.GetInt32(myReader.GetOrdinal("StatusId"))
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

        public bool GetCopies(out List<Copy> copiesList)
        {
            copiesList = new List<Copy>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    copiesList.Add(new Copy()
                    {
                        Barcode = myReader.GetString(myReader.GetOrdinal("Barcode")),
                        ISBN = myReader.GetString(myReader.GetOrdinal("ISBN")),
                        Location = myReader.GetString(myReader.GetOrdinal("Location")),
                        Library = myReader.GetString(myReader.GetOrdinal("Library")),
                        StatusId = myReader.GetInt32(myReader.GetOrdinal("StatusId"))
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

        public bool GetStatus(out List<Status> statusList)
        {
            statusList = new List<Status>();
            SqlDataReader myReader = null;

            try
            {
                connection.Open();
                SqlCommand myCommand = new SqlCommand("select * from dbo.BORROWER", connection);

                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    statusList.Add(new Status()
                    {
                        StatusId = myReader.GetInt32(myReader.GetOrdinal("StatusId")),
                        StatusName = myReader.GetString(myReader.GetOrdinal("Status"))
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
