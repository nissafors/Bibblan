using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Models;

namespace Bibblan.Models
{
    public class BorrowerViewModel
    {
        public string PersonId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Adress { get; set; }
        public string TelephoneNumber { get; set; }

        public SelectList Category { get; set; }
        public int ChosenCategory { get; set; }

        public BorrowerViewModel(Borrower borrower)
        {
            this.PersonId = borrower.PersonId;
            this.FirstName = borrower.FirstName;
            this.LastName = borrower.LastName;
            this.Adress = borrower.Adress;
            this.TelephoneNumber = borrower.TelephoneNumber;

            this.Category = new SelectList(Services.Mockup.Mockup.categories, "Id", "CategoryName", borrower.Category);
            this.ChosenCategory = borrower.Category.Id;
        }

        public BorrowerViewModel()
        {
            this.Category = new SelectList(Services.Mockup.Mockup.categories, "Id", "CategoryName");
        }

	}
}