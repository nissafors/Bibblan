using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Models
{
    class Borrower
    {
        public string PersonId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Adress { get; set; }
        public string TelephoneNumber { get; set; }
        public int CategoryId { get; set; }
        public List<Loan> Loans { get; set; }
    }
}
