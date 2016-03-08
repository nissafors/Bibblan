using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
        public int RoleId { get; set; }

        public static bool getAccount(out Account account, string username, string password)
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

        public static bool getUserRole(string username, out UserRole role)
        {
            role = null;
            foreach (var a in accountMockups)
            {
                if (a.Username == username)
                {
                    role = a.RoleId;
                }
            }
        }
    }
}
