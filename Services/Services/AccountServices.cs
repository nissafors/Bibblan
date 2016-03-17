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
           Account.GetAccount(out account, model.Username, model.Password);

           if (account == null)
               return null;

           return Mapper.Map<AccountViewModel>(account);
        }
        public static bool AccountExists(string username)
        {
            bool b;
            Account.AccountExists(out b, username);
            return b;
        }

        public static int GetRoleId(string username)
        {
            UserRole role;
            Account.GetUserRole(username, out role);
            return role.Id;
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
    }
}
