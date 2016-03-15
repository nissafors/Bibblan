using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.Repositories;

namespace Repository.EntityModels
{
    public class Borrower
    {
        public string PersonId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Adress { get; set; }
        public string TelNo { get; set; }
        public int CategoryId { get; set; }

        /// <summary>
        /// Get the borrower with the supplied PersonId from the database
        /// </summary>
        /// <param name="borrower"></param>
        /// <param name="PersonId"></param>
        /// <returns></returns>
        public static bool GetBorrower(out Borrower borrower, string PersonId)
        {
            borrower = null;

            SqlCommand command = new SqlCommand("SELECT * from BORROWER WHERE PersonId = @PersonId");
            command.Parameters.AddWithValue("@PersonId", PersonId);

            List<Borrower> borrowerList;

            bool result = GetBorrowers(out borrowerList, command);

            if (borrowerList.Count > 0)
            {
                borrower = borrowerList[0];
            }

            return result;
        }

        /// <summary>
        /// Get all borrowers where PersonId, first name and/or last name matches the searchParameter
        /// </summary>
        /// <param name="borrowerList"></param>
        /// <param name="searchParameter"></param>
        /// <returns></returns>
        public static bool GetBorrowers(out List<Borrower> borrowerList, string searchParameter)
        {
            searchParameter = HelperFunctions.SetupSearchString(searchParameter);
            SqlCommand command = new SqlCommand("SELECT * from BORROWER WHERE PersonId + FirstName + LastName LIKE @SearchParameter");
            command.Parameters.AddWithValue("@SearchParameter", searchParameter);

            return GetBorrowers(out borrowerList, command);
        }

        /// <summary>
        /// Get all borrowers in the database
        /// </summary>
        /// <param name="borrowerList"></param>
        /// <returns></returns>
        public static bool GetBorrowers(out List<Borrower> borrowerList)
        {
            return GetBorrowers(out borrowerList, new SqlCommand("SELECT * from BORROWER"));
        }

        private static bool GetBorrowers(out List<Borrower> borrowerList, SqlCommand command)
        {
            borrowerList = new List<Borrower>();

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
                                borrowerList.Add(new Borrower()
                                {
                                    PersonId = Convert.ToString(myReader["PersonId"]),
                                    FirstName = Convert.ToString(myReader["FirstName"]),
                                    LastName = Convert.ToString(myReader["LastName"]),
                                    Adress = Convert.ToString(myReader["Address"]),
                                    CategoryId = Convert.ToInt32(myReader["CategoryId"]),
                                    TelNo = Convert.ToString(myReader["TelNo"])
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

        /// <summary>
        /// Update or insert a borrower
        /// </summary>
        /// <param name="borrower"></param>
        /// <returns></returns>
        public static bool Upsert(Borrower borrower)
        {
            try
            {
                using (SqlConnection connection = DatabaseConnection.GetConnection())
                {
                    connection.Open();
                    // Update BOOK
                    using (SqlCommand command = new SqlCommand("EXEC UpsertBorrower @PersonId, @FirstName, @LastName, @Address, @Telno, @CategoryId"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@PersonId", borrower.PersonId);
                        command.Parameters.AddWithValue("@FirstName", DBNullHelper.ValueOrDBNull(borrower.FirstName));
                        command.Parameters.AddWithValue("@LastName", DBNullHelper.ValueOrDBNull(borrower.LastName));
                        command.Parameters.AddWithValue("@Address", DBNullHelper.ValueOrDBNull(borrower.Adress));
                        command.Parameters.AddWithValue("@Telno", DBNullHelper.ValueOrDBNull(borrower.TelNo));
                        command.Parameters.AddWithValue("@CategoryId", DBNullHelper.ValueOrDBNull(borrower.CategoryId));

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
        /// Delete the borrower with the key PersonId from the database
        /// </summary>
        /// <param name="PersonId"></param>
        /// <returns></returns>
        public static bool Delete(string PersonId)
        {
            try
            {
                using (SqlConnection connection = DatabaseConnection.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("DELETE FROM BORROW WHERE PersonId = @PersonId", connection))
                    {
                        command.Parameters.AddWithValue("@PersonId", PersonId);

                        command.ExecuteNonQuery();
                    }

                    using (SqlCommand command = new SqlCommand("DELETE FROM BORROWER WHERE PersonId = @PersonId", connection))
                    {
                        command.Parameters.AddWithValue("@PersonId", PersonId);

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
    }
}
