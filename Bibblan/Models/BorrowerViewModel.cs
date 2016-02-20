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
        public int ChosenCategory { get; set; }

        public BorrowerViewModel(string personId)
            : this()
        {
            this.setup(_borrowerServices.GetBorrowerById(personId));
        }

        public BorrowerViewModel(Borrower borrower) 
            : this()
        {
            this.setup(borrower);
        }

        public BorrowerViewModel()
        {
            this.Category = new SelectList(_categoryServices.GetAllCategories(), "Id", "CategoryName");
        }

        private void setup(Borrower borrower)
        {
            if (borrower != null)
            {
                this.PersonId = borrower.PersonId;
                this.FirstName = borrower.FirstName;
                this.LastName = borrower.LastName;
                this.Adress = borrower.Adress;
                this.TelephoneNumber = borrower.TelephoneNumber;
                this.ChosenCategory = borrower.Category.Id;
            }
        }
	}
}