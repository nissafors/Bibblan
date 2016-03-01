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
        public DateTime ToBeReturnedDate { get; set; }
        public DateTime ReturnDate { get; set; }

        static public bool GetBorrows(out List<Borrow> borrowList, string searchParameter)
        {
            borrowList = new List<Borrow>();
            SqlCommand command = new SqlCommand("SELECT * from dbo.BORROW WHERE Barcode = @Barcode OR PersonId = @PersonId");
            command.Parameters.AddWithValue("Barcode", searchParameter);
            command.Parameters.AddWithValue("PersonId", searchParameter);

            return GetBorrows(out borrowList, command);
        }

        static public bool GetBorrows(out List<Borrow> borrowList)
        {
            borrowList = new List<Borrow>();
            return GetBorrows(out borrowList, new SqlCommand("SELECT * from dbo.BORROW"));
        }

        static private bool GetBorrows(out List<Borrow> borrowList, SqlCommand command)
        {
            borrowList = new List<Borrow>();

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
                                    Barcode = myReader.GetString(myReader.GetOrdinal("Barcode")),
                                    PersonId = myReader.GetString(myReader.GetOrdinal("PersonId")),
                                    BorrowDate = myReader.GetDateTime(myReader.GetOrdinal("BorrowDate")),
                                    ReturnDate = myReader.GetDateTime(myReader.GetOrdinal("ReturnDate")),
                                    ToBeReturnedDate = myReader.GetDateTime(myReader.GetOrdinal("ToBeReturnedDate"))
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
