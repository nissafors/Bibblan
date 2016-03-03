using System.ComponentModel.DataAnnotations;

namespace Common.Models
{


    public class LoginViewModel
    {
        [Required]
        [Display(Name = "Biblioteks id")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Lösenord")]
        public string Password { get; set; }

        [Display(Name = "Kom ihåg mig?")]
        public bool RememberMe { get; set; }
    }

    public class AccountViewModel
    {
        public string UserName { get; set; }
        public bool isAdmin { get; set; }
    }
}
