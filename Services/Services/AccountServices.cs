using AutoMapper;
using Common.Models;
using Repository.EntityModels;
using Services.Exceptions;
using System.Collections.Generic;

namespace Services.Services
{
    public class AccountServices
    {
        public static AccountViewModel Login(AccountViewModel model)
        {
           Account account;      

           if (!Account.GetAccount(out account, model.Username, model.Password))
               throw new DoesNotExistException("Fel lösenord / användarnamn ");

           return Mapper.Map<AccountViewModel>(account);
        }

        /// <summary>
        /// Remove a given user from the repository
        /// </summary>
        /// <param name="model"></param>
        public static void Delete(AccountViewModel model)
        {
            var account = Mapper.Map<Account>(model);

            if (!Account.Delete(account))
                throw new DataAccessException("Kunde inte ta bort användare");
        }
        /// <summary>
        /// Verify if an Account Exists in the Repository
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public static bool AccountExists(string username)
        {
            bool b;
            if (!Account.AccountExists(out b, username))
                throw new DataAccessException("Kunde inte ansluta");
            return b;
        }

        /* 
        public static AccountViewModel GetAccount(string username)
        {
            Account account;
            
            if (!Account.GetAccount(out account, username))
                throw new DoesNotExistException("Användaren finns inte");

            return Mapper.Map<AccountViewModel>(account);
        }
        */

        public static int GetRoleId(string username)
        {
            UserRole role;
            Account.GetUserRole(username, out role);
            return role.Id;
        }

        public static List<AccountViewModel> GetAccounts(Role role)
        {
            List<Account> accounts;
            if (!Account.GetAccounts(out accounts, (int) role))
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
