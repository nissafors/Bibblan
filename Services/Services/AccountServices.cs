using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using System.Security.Cryptography;
using Repository.EntityModels;
namespace Services.Services
{
    public class AccountServices
    {
        public AccountViewModel Login(LoginViewModel model)
        {
            var pass = model.Password;
            var name = model.UserName;
            string preHash = "";
            // Salt
            for(int i = 0; i < pass.Length; i++)
            {
                int c0 = pass[i];
                int c1 = name[i];
                preHash += (char) (c0 ^ c1);
            }
            preHash += model.Password;
            SHA256 hashFunction = SHA256Managed.Create();
            var hash = hashFunction.ComputeHash(Encoding.UTF8.GetBytes(preHash))
            var output = hash.ToString();
        }
        // TODO LOGIN LOGOUT
        /* 
        public Borrower Login()
        {

        }
        */
        /*
        public List<Loan> GetLoans(Borrower user)
        {
            return user.Loans;
        }
        */
    }
}
