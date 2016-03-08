using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Repository.Repositories;

namespace Repository.EntityModels
{
    public class Borrow
    {
        public string Barcode { get; set; }
        public string PersonId { get; set; }
        public DateTime BorrowDate { get; set; }
        public DateTime? ToBeReturnedDate { get; set; }
        public DateTime ReturnDate { get; set; }

        public static bool GetBorrows(out List<Borrow> borrowList, string searchParameter)
        {
            SqlCommand command = new SqlCommand("SELECT * from BORROW WHERE Barcode = @Barcode OR PersonId = @PersonId");
            command.Parameters.AddWithValue("@Barcode", searchParameter);
            command.Parameters.AddWithValue("@PersonId", searchParameter);

            return GetBorrows(out borrowList, command);
        }

        public static bool GetBorrows(out List<Borrow> borrowList)
        {
            return GetBorrows(out borrowList, new SqlCommand("SELECT * from BORROW"));
        }

        private static bool GetBorrows(out List<Borrow> borrowList, SqlCommand command)
        {
            borrowList = new List<Borrow>();

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
                                    borrowList.Add(new Borrow()
                                    {
                                        Barcode = Convert.ToString(myReader["Barcode"]),
                                        PersonId = Convert.ToString(myReader["PersonId"]),
                                        BorrowDate = Convert.ToDateTime(myReader["BorrowDate"]),
                                        ReturnDate = Convert.ToDateTime(myReader["ReturnDate"]),
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
            catch(Exception)
            {
                return false;
            }

            return true;
        }

        public static bool UpdateReturnDate(Borrow borrow)
        {
            try
            {
                using (SqlConnection connection = DatabaseConnection.GetConnection())
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
            return false;
        }
    }
}
