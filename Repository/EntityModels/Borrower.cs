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

        static public bool GetBorrower(out Borrower borrower, string PersonId)
        {
            borrower = null;
            
            SqlCommand command = new SqlCommand("SELECT * from dbo.BORROWER WHERE PersonId = @PersonId");
            command.Parameters.AddWithValue("PersonId", PersonId);
            
            List<Borrower> borrowerList;
            
            bool result = GetBorrowers(out borrowerList, command);
            
            if (borrowerList.Count > 0)
            {
                borrower = borrowerList[0];
            }

            return result;
        }

        public static bool GetBorrowers(out List<Borrower> borrowerList, string searchParameter)
        {
            borrowerList = new List<Borrower>();
            // TODO: Search by index
            SqlCommand command = new SqlCommand("SELECT * from dbo.BORROWER WHERE PersonId = @SearchParameter");
            command.Parameters.AddWithValue("SearchParameter", searchParameter);

            return GetBorrowers(out borrowerList, command);
        }

        public bool GetBorrowers(out List<Borrower> borrowerList)
        {
            borrowerList = new List<Borrower>();
            return GetBorrowers(out borrowerList, new SqlCommand("SELECT * from dbo.AUTHOR"));
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
                                    PersonId = myReader.GetString(myReader.GetOrdinal("PersonId")),
                                    FirstName = myReader.GetString(myReader.GetOrdinal("FirstName")),
                                    LastName = myReader.GetString(myReader.GetOrdinal("LastName")),
                                    Adress = myReader.GetString(myReader.GetOrdinal("Adress")),
                                    CategoryId = myReader.GetInt32(myReader.GetOrdinal("CategoryId")),
                                    TelNo = myReader.GetString(myReader.GetOrdinal("TelNo"))
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
