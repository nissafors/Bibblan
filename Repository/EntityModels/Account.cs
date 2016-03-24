using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace Repository.EntityModels
{
    public class Account
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string BorrowerId { get; set; }
        public string Salt { get; set; }
        public int RoleId { get; set; }

        /// <summary>
        /// Update account in DB, if it does not exist create new
        /// </summary>
        /// <param name="account"></param>
        /// <returns></returns>
        public static bool Upsert(Account account)
        {
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    // Make a new hash for the user
                    var hash = makeHash(account.Password);
                    account.Password = hash[0];
                    account.Salt = hash[1];
                    using (SqlCommand command = new SqlCommand("EXEC UpsertAccount @Username, @Password, @Salt, @RoleId, @BorrowerId"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@Username", account.Username);
                        command.Parameters.AddWithValue("@Password", account.Password);
                        command.Parameters.AddWithValue("@Salt", account.Salt);
                        command.Parameters.AddWithValue("@RoleId", account.RoleId);
                        command.Parameters.AddWithValue("@BorrowerId", HelperFunctions.ValueOrDBNull(account.BorrowerId));

                        if (command.ExecuteNonQuery() != 1)
                        {
                            return false;
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
        /// Delete an Account from repository
        /// </summary>
        /// <param name="account"></param>
        /// <returns></returns>
        public static bool Delete(Account account)
        {
            try
            {
                using (SqlConnection connection = HelperFunctions.GetConnection())
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("DELETE FROM ACCOUNT WHERE Username = @Username"))
                    {
                        command.Connection = connection;
                        command.Parameters.AddWithValue("@Username", account.Username);
                        if (command.ExecuteNonQuery() != 1)
                        {
                            return false;
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
        /// Get accounts with a specified role if (-1) it means all
        /// </summary>
        /// <param name="accounts"></param>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public static bool GetAccounts(out List<Account> accounts, int roleId)
        {
            SqlCommand command;
            if(roleId == -1)
                command = new SqlCommand("SELECT Username, RoleId FROM ACCOUNT");
            else
                command = new SqlCommand("SELECT Username, RoleId FROM ACCOUNT WHERE RoleId = @RoleId");

            command.Parameters.AddWithValue("@RoleId", roleId);
            return getAccounts(out accounts, command);
        }

        /// <summary>
        /// Selects row with give username & checks if the password hash with the row salt matches
        /// the password hash in the table
        /// </summary>
        /// <param name="account"></param>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public static bool GetAccount(out Account account, string username, string password)
        { 
            var accounts = new List<Account>();
            var command = new SqlCommand("SELECT * FROM ACCOUNT WHERE Username = @Username");
            command.Parameters.AddWithValue("@Username", username);
            var ret = getAccounts(out accounts, command);

            account = null;
            if (ret && accounts.Count > 0)
                account = accounts[0];
            else
                return false;

            // Check password
            if (makeHash(password, account.Salt) == account.Password)
                return true;
            else
            {
                account = null;
                return false;
            }
        }
        /// <summary>
        /// Check if account exists
        /// </summary>
        /// <param name="exists"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        public static bool AccountExists(out bool exists, string username)
        {
            var accounts = new List<Account>();
            var command = new SqlCommand("SELECT Username, RoleId FROM ACCOUNT WHERE Username = @Username");
            command.Parameters.AddWithValue("@Username", username);

            var ret = getAccounts(out accounts, command);
            exists = accounts.Count > 0;

            return ret;
        }

        /// <summary>
        /// Get userrole of a given user
        /// </summary>
        /// <param name="username"></param>
        /// <param name="role"></param>
        /// <returns></returns>
        public static bool GetUserRole(string username, out UserRole role)
        {
            var command = new SqlCommand("SELECT ACCOUNT.RoleId, USER_ROLES.Role FROM ACCOUNT INNER JOIN USER_ROLES ON ACCOUNT.RoleId = USER_ROLES.RoleId WHERE Username = @Username");
            command.Parameters.AddWithValue("@Username", username);
            role = null;
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
                                while(myReader.Read())
                                {
                                    var id = Convert.ToInt32(myReader["RoleId"]);
                                    var roledesc = Convert.ToString(myReader["Role"]);
                                    role = new UserRole() {Id = id, Role = roledesc};
                                    return true;
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
            return false;
        }
            
        // Number of iterations to do the keystretch
        private const int PBKDFITERATIONS = 10000;
        //B per salt
        private const int RNGLENGHT = 32;

        /// <summary>
        /// Create a cryptographically secure hash with HMAC sha1 as a CSPRNG 
        /// Returns a two dimenstional string with index 0 being the hashed password
        /// & index 1 being the salt
        /// </summary>
        /// <param name="password"></param>
        /// <returns></returns>
        private static string[] makeHash(string password)
        {
            Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(password, RNGLENGHT, PBKDFITERATIONS);
            var hash = pbkdf2.GetBytes(20);
            return new string[] { Convert.ToBase64String(hash), Convert.ToBase64String(pbkdf2.Salt) };
        }
       
        /// <summary>
        /// Create a hash using a specified salt
        /// </summary>
        /// <param name="password"></param>
        /// <param name="salt"></param>
        /// <returns></returns>
        private static string makeHash(string password, string salt)
        {
            Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(password, Convert.FromBase64String(salt));
            pbkdf2.IterationCount = PBKDFITERATIONS;
            return Convert.ToBase64String(pbkdf2.GetBytes(20));
        }

        /// <summary>
        /// Helper function that returns accounts from a given SQL-query
        /// </summary>
        /// <param name="accounts"></param>
        /// <param name="command"></param>
        /// <returns></returns>
        private static bool getAccounts(out List<Account> accounts, SqlCommand command)
        {
            accounts = new List<Account>();
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
                                while(myReader.Read())
                                {
                                    var fields = HelperFunctions.hasFields(myReader,new List<string> {"Password", "Salt", "BorrowerId"});

                                    string password = !fields.Contains("Password") ? null : Convert.ToString(myReader["Password"]);
                                    string salt = !fields.Contains("Salt") ? null : Convert.ToString(myReader["Salt"]);
                                    string borrowerId = !fields.Contains("BorrowerId") ? null : Convert.ToString(myReader["BorrowerId"]);
                                    accounts.Add(new Account()
                                    {
                                        Username = Convert.ToString(myReader["Username"]),
                                        RoleId = Convert.ToInt32(myReader["RoleId"]),
                                        Password = password,
                                        Salt = salt,
                                        BorrowerId = borrowerId
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
