using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using AutoMapper;

namespace Services.Services
{
    public class AccountServices
    {
        public static AccountViewModel Login(AccountViewModel model)
        {
           Account account;
           Account.getAccount(out account, model.Username, model.Password);

           if (account == null)
               return null;

           return Mapper.Map<AccountViewModel>(account);
        }

        public static int getRole(string username)
        {
            
        }
        /*
        public List<Loan> GetLoans(Borrower user)
        {
            return user.Loans;
        }
        */
    }
}
