using System.ComponentModel.DataAnnotations;

namespace Common.Models
{
    /// <summary>
    /// View model for /Edit/Author.</summary>
    /// <remarks>
    /// Also used in lists by /Browse/Author and /Search/Author.</remarks>
    public class AuthorViewModel
    {
        [Display(Name = "Förnamn")]
        public string FirstName { get; set; }
        [Display(Name = "Efternamn")]
        [Required(ErrorMessage ="Ett efternamn krävs.")]
        public string LastName { get; set; }
        [Display(Name = "Födelseår")]
        public string BirthYear { get; set; }
        public int Aid { get; set; }
    }
}
