using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;
using Services.Services;

namespace Bibblan.Models
{
    public class BorrowerViewModel
    {
        private BorrowerServices _borrowerServices = new BorrowerServices();
        private CategoryServices _categoryServices = new CategoryServices();

        public string PersonId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Adress { get; set; }
        public string TelephoneNumber { get; set; }

        public SelectList Category { get; set; }
        public int SelectedCategory { get; set; }

        public BorrowerViewModel(Borrower borrower)
            : this()
        {
            this.PersonId = borrower.PersonId;
            this.FirstName = borrower.FirstName;
            this.LastName = borrower.LastName;
            this.Adress = borrower.Adress;
            this.TelephoneNumber = borrower.TelephoneNumber;
            this.SelectedCategory = borrower.Category.Id;
        }

        public BorrowerViewModel()
        {
            this.Category = new SelectList(_categoryServices.GetAllCategories(), "Id", "CategoryName");
        }

        public Borrower ToBorrower()
        {
            return new Borrower
            {
                PersonId = this.PersonId,
                FirstName = this.FirstName,
                LastName = this.LastName,
                Adress = this.Adress,
                TelephoneNumber = this.TelephoneNumber,
                Category = CategoryServices.GetCategory(SelectedCategory)
            };
        }
    }
}