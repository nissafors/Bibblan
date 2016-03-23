using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Repository.EntityModels
{
    public class Borrow
    {
        public string Barcode { get; set; }
        public string PersonId { get; set; }
        public DateTime BorrowDate { get; set; }
        public DateTime ToBeReturnedDate { get; set; }
        public DateTime? ReturnDate { get; set; }

        /// <summary>
        /// Get all Borrow:s matching either Barcode or PersonId.
        /// </summary>
        /// <param name="borrowList">A List of Borrow:s. Will be initialized to a new instance.
        /// May be empty after execution if no records were found.</param>
        /// <param name="searchParameter">Barcode or PersonId as a string.</param>
        /// <returns>Returns true if no errors occured.</returns>
        public static bool GetBorrows(out List<Borrow> borrowList, string searchParameter)
        {
            SqlCommand command = new SqlCommand("SELECT * from BORROW WHERE Barcode = @Barcode OR PersonId = @PersonId");
            command.Parameters.AddWithValue("@Barcode", searchParameter);
            command.Parameters.AddWithValue("@PersonId", searchParameter);

            return getBorrows(out borrowList, command);
        }

        /// <summary>
        /// Get all Borrow:s for borrower with personId that have not been returned
        /// </summary>
        /// <param name="borrowList">A List of Borrow:s. Will be initialized to a new instance.
        /// May be empty after execution if no records were found.</param>
        /// <param name="personId">The PersonId of the borrower.</param>
        /// <returns>Returns true if no errors occured.</returns>
        public static bool GetActiveBorrows(out List<Borrow> borrowList, string personId)
        {
            SqlCommand command = new SqlCommand("SELECT * from BORROW WHERE PersonId = @PersonId AND ReturnDate IS NULL");
            command.Parameters.AddWithValue("@PersonId", personId);

            return getBorrows(out borrowList, command);
        }

        /// <summary>
        /// Get all borrows in the database.
        /// </summary>
        /// <param name="borrowList">A List of Borrow:s. Will be initialized to a new instance.
        /// May be empty after eecution if no records were found.</param>
        /// <returns>Returns true if no errors occured.</returns>
        public static bool GetBorrows(out List<Borrow> borrowList)
        {
            return getBorrows(out borrowList, new SqlCommand("SELECT * from BORROW"));
        }

        /// <summary>
        /// Write a new ToBeReturnedDate to the database.
        /// </summary>
        /// <param name="borrow">The Borrow object to update.</param>
        /// <returns>Return true if one row was written and no error occured.</returns>
        public static bool UpdateReturnDate(Borrow borrow)
        {
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("UPDATE SET ToBeReturnedDate = @ToBeReturnedDate WHERE Barcode = @Barcode AND PersonId = @PersonId", connection))
                    {
                        command.Parameters.AddWithValue("@Barcode", borrow.Barcode);
                        command.Parameters.AddWithValue("@PersonId", borrow.PersonId);
                        
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

        /// <summary>
        /// Execute command and place fetched records in a list.
        /// </summary>
        /// <param name="borrowList">A List of Borrow:s. Will be initialized to a new instance.
        /// May be empty after eecution if no records were found.</param>
        /// <param name="command">The SqlCommand to execute.</param>
        /// <returns>Returns true if no error occured.</returns>
        private static bool getBorrows(out List<Borrow> borrowList, SqlCommand command)
        {
            borrowList = new List<Borrow>();

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
                                    borrowList.Add(new Borrow()
                                    {
                                        Barcode = Convert.ToString(myReader["Barcode"]),
                                        PersonId = Convert.ToString(myReader["PersonId"]),
                                        BorrowDate = Convert.ToDateTime(myReader["BorrowDate"]),
                                        ReturnDate = myReader["ReturnDate"] as DateTime?,
                                        ToBeReturnedDate = Convert.ToDateTime(myReader["ToBeReturnedDate"])
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
