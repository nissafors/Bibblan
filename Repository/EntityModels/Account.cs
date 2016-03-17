using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace Repository.EntityModels
{
    public class Account
    {
         /// <summary>
        /// Mockups for accounts
        /// </summary>
        private static List<Account> accountMockups = new List<Account>()
        {
            new Account {Username = "person1", Password = "1234", RoleId = 0}, // Admin
            new Account {Username = "person2", Password = "1248", RoleId = 0}, // Admin
            new Account {Username = "Olof", Password = "0kOrv", PersonId = "920201-1212", RoleId = 1}, // User
            new Account {Username = "AnDer s", Password = "00000", PersonId = "930801-2727", RoleId = 1} // User
        };

        public string Username { get; set; }
        public string Password { get; set; }
        public string PersonId { get; set; }
        public string Salt { get; set; }
        public int RoleId { get; set; }

        // TODO: Refactor get from sql
        public static bool GetAccount(out Account account, string username, string password)
        {
            account = null;
            foreach(var a in accountMockups)
            {
                if(a.Username == username && a.Password == password)
                {
                    account = a;
                    return true;
                }
            }
            return false;
        }

        public static bool AccountExists(out bool exists, string username)
        {
            foreach(var a in accountMockups)
            {
                if(a.Username == username)
                    return exists = true;
            }
            return exists = false;
        }

        public static bool GetUserRole(string username, out UserRole role)
        {
            role = null;
            foreach (var a in accountMockups)
            {
                if (a.Username == username)
                {
                    UserRole.getRole(out role, a.RoleId);
                    return true;
                }
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
    }
}
