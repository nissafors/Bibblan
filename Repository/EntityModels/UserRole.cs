using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.EntityModels
{
    /// <summary>
    /// Different Roles for acess to diffent parts of the website
    /// </summary>
    public class UserRole
    {
        /// <summary>
        /// Mockups for userroles
        /// 
        /// </summary>
        private static List<UserRole> mockupRoles = new List<UserRole>()
        {
            new UserRole {Id = 0, Role = "Admin"},
            new UserRole {Id = 1, Role = "Borrower"}
        };
        public int Id {get; set;}
        public string  Role { get; set; }
        public static bool getUserRoles(out List<UserRole> roles)
        {
            roles = mockupRoles;
            return true;
        }

        public static bool getRole(out UserRole role, int id)
        {
            role = mockupRoles[id];
            return true;
        }
    }
}
