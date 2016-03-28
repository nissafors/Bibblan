using AutoMapper;
using Common.Models;
using Repository.EntityModels;
using Services.Exceptions;
using System.Collections.Generic;

namespace Services.Services
{
    public class AccountServices
    {
        /// <summary>
        /// Tries to get an account entity model to map to a viewmodel from the repository
        /// Based on a given viewmodel
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
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

        /// <summary>
        /// Return the role of a given username
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public static int GetRoleId(string username)
        {
            UserRole role;
            if (!Account.GetUserRole(username, out role))
                throw new DataAccessException("Kunde inte hitta roll");
            return role.Id;
        }

        /// <summary>
        /// Return accouts that have a given role
        /// </summary>
        /// <param name="role"></param>
        /// <returns></returns>
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
