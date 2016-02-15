using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;

namespace Services.Mockup
{
    public class Mockup
    {
        static public List<Classification> classifications = new List<Classification>
        {
            new Classification{ Id=1, Signum="Pub", Description="NULL" },
            new Classification{ Id=2, Signum="Puba", Description="NULL" },
            new Classification{ Id=3, Signum="Pubb", Description="NULL" },
            new Classification{ Id=4, Signum="Pubbz Ada", Description="NULL" }
        };

        static public List<Category> categories = new List<Category>
        {
            new Category{ Id=1, CategoryName="Extern", Period=30, PenaltyPerDay=5},
            new Category{ Id=2, CategoryName="Personal", Period=40, PenaltyPerDay=0},
            new Category{ Id=3, CategoryName="Studerande", Period=60, PenaltyPerDay=1},
            new Category{ Id=4, CategoryName="Barn", Period=30, PenaltyPerDay=0}
        };

        static public List<Borrower> borrowers = new List<Borrower>
        {
            new Borrower{PersonId="19111111-1111",LastName="Elvansson", FirstName="Elvan", Adress="Älvv.11 11111 Älvstad", TelephoneNumber="0111-111111", CategoryId=1},
            new Borrower{PersonId="19121212-1212",LastName="Tolvansson", FirstName="Tolvan", Adress="Tolvv.12 12121 Tolvstad", TelephoneNumber="0121-121212", CategoryId=2}
        };
    }
}
