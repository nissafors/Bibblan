using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;
using AutoMapper;
using Services.Exceptions;

namespace Services.Services
{
    public class AccountServices
    {
        public static AccountViewModel Login(AccountViewModel model)
        {
           Account account;
           

           if (!Account.GetAccount(out account, model.Username, model.Password))
               throw new DoesNotExistException("Fel lösenord / användarnamn");

           return Mapper.Map<AccountViewModel>(account);
        }

        public static bool AccountExists(string username)
        {
            bool b;
            Account.AccountExists(out b, username);
            return b;
        }

        public static AccountViewModel GetAccount(string username)
        {
            Account account;
            
            if (!Account.GetAccount(out account, username))
                throw new DoesNotExistException("Användaren finns inte");

            return Mapper.Map<AccountViewModel>(account);
        }

        public static int GetRoleId(string username)
        {
            UserRole role;
            Account.GetUserRole(username, out role);
            return role.Id;
        }

        public static List<AccountViewModel> GetAccounts(int roleId = -1)
        {
            List<Account> accounts;
            if (!Account.GetAccounts(out accounts, roleId))
                throw new DataAccessException("Kunde inte komma åt användare");

            List<AccountViewModel> models = new List<AccountViewModel>();
            foreach (var account in accounts)
                models.Add(Mapper.Map<AccountViewModel>(account));

            return models;
        }

        public List<RoleViewModel> GetUserRoles()
        {
            List<UserRole> roles;
            UserRole.getUserRoles(out roles);
            var models = new List<RoleViewModel>();
            foreach(var role in roles)
            {
                models.Add(Mapper.Map<RoleViewModel>(role));
            }
            return models;

        }
        // Creates a new account
        public static void Upsert(AccountViewModel model)
        {
            var account = Mapper.Map<Account>(model);
            // Update Password if changed
            if (model.NewPassword != null)
                account.Password = model.NewPassword;

            if (!Account.Upsert(account))
                throw new DataAccessException("Kunde inte skapa användare!");
        }
    }
}
