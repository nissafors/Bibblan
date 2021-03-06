﻿using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web.Mvc;

namespace Common.Models
{
    /// <summary>
    /// View model for /Edit/Borrower.</summary>
    public class BorrowerViewModel
    {
        [Required(ErrorMessage="Ett personnummer krävs")]
        [RegularExpression(@"^\d{8}-\d{4}$", ErrorMessage="Personnummer måste vara i formen YYYYMMDD-XXXX")]
        [Display(Name = "Personnummer")]
        public string PersonId { get; set; }
        [Display(Name = "Förnamn")]
        public string FirstName { get; set; }
        [Display(Name = "Efternamn")]
        public string LastName { get; set; }
        [Display(Name = "Adress")]
        public string Adress { get; set; }
        [Display(Name = "Telefonnummer")]
        public string TelNo { get; set; }
        [Display(Name = "Lån")]
        public List<BorrowViewModel> Borrows { get; set; }

        [Display(Name = "Kategori")]
        public SelectList Category { get; set; }
        public int CategoryId { get; set; }
        [Display(Name = "Kategori")]
        public string CategoryName 
        { 
            get 
            { 
                return Category.Where(p => p.Value == CategoryId.ToString()).First().Text; 
            } 
        }

        public bool New { get; set; }
        public AccountViewModel Account { get; set; }

        public BorrowerViewModel()
        {
            Borrows = new List<BorrowViewModel>();
            Account = new AccountViewModel();
        }
    }
}