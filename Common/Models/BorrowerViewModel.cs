using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace Common.Models
{
    public class BorrowerViewModel
    {
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

        [Display(Name = "Kategori")]
        public SelectList Category { get; set; }
        public int SelectedCategory { get; set; }
        public string CategoryName 
        { 
            get 
            { 
                return Category.Where(p => p.Value == SelectedCategory.ToString()).First().Text; 
            } 
        }

        //public BorrowerViewModel(Dictionary<int, string> categoryList)
        //{
        //    this.Category = new SelectList(categoryList.OrderBy(x => x.Value), "Key", "Value");
        //}
    }
}