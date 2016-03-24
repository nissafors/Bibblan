using System.ComponentModel.DataAnnotations;

namespace Common.Models
{
    public enum Role { admin, borrower , all = -1}

    public class AccountViewModel
    {
        [Display(Name = "Användarnamn")]
        public string Username { get; set; }
        
        [Display(Name = "Lösenord")]
        [MinLength(4, ErrorMessage = "Måste ha minst 4 tecken")]
        public string Password { get; set; }
        
        [Display(Name = "Nytt Lösenord")]
        [MinLength(4, ErrorMessage = "Måste ha minst 4 tecken")]
        public string NewPassword { get; set; }

        [Display(Name = "Lösenord igen")]
        [MinLength(4, ErrorMessage = "Måste ha minst 4 tecken")]
        [CompareAttribute("NewPassword", ErrorMessage="Lösenorden är inte lika.")]
        public string NewPasswordAgain { get; set; }
        
        public int RoleId { get; set; }
        public string BorrowerId { get; set; }

        public bool New { get; set; }
    }

    public class RoleViewModel
    {
        public int Id { get; set; }
        public string Role { get; set; }
    }
}
