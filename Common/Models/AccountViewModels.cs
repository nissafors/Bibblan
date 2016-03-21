using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Common.Models
{
    public enum Role { admin, borrower }

    public class AccountViewModel
    {
        [Display(Name = "Användarnamn")]
        public string Username { get; set; }
        
        [Display(Name = "Lösenord")]
        public string Password { get; set; }
        
        [Display(Name = "Lösenord")]
        public string NewPassword { get; set; }

        // System.ComponentModel.DataAnnotations.CompareAttribute should be used instead of
        // System.Web.Mvc.Compare but it contains known bug in our version
        [Display(Name = "Lösenord igen")]
        [System.Web.Mvc.Compare("NewPassword", ErrorMessage="Lösenorden är inte lika.")]
        public string NewPasswordAgain { get; set; }
        
        public int RoleId { get; set; }
        
        public string PersonId { get; set; }
    }

    public class RoleViewModel
    {
        public int Id { get; set; }
        public string Role { get; set; }
    }
}
