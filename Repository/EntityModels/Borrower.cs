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

        public static bool GetBorrowers(out List<Borrower> borrowerList, string searchParameter)
        {
            searchParameter = HelperFunctions.SetupSearchString(searchParameter);
            SqlCommand command = new SqlCommand("SELECT * from BORROWER WHERE PersonId + FirstName + LastName LIKE @SearchParameter");
            command.Parameters.AddWithValue("@SearchParameter", searchParameter);

            return GetBorrowers(out borrowerList, command);
        }

        public bool GetBorrowers(out List<Borrower> borrowerList)
        {
            return GetBorrowers(out borrowerList, new SqlCommand("SELECT * from BORROWER"));
        }

        private static bool GetBorrowers(out List<Borrower> borrowerList, SqlCommand command)
        {
            borrowerList = new List<Borrower>();

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
            }
            catch(Exception)
            {
                return false;
            }

            return true;
        }
    }
}
