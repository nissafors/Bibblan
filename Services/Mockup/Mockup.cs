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

        static public List<Author> authors = new List<Author>
            {
                new Author { Id = 1, FirstName = "Pelle", LastName = "Persson", BirthYear = 1900 },
                new Author { Id = 2, FirstName = "Kalle", LastName = "Karlsson", BirthYear = 1800 },
                new Author { Id = 3, FirstName = "Olle", LastName = "Olsson", BirthYear = 1700 },
            };

        static public List<BookAuthor> bookAuthors = new List<BookAuthor>
            {
                new BookAuthor { ISBN = "1234-5", AuthorId = 1 },
                new BookAuthor { ISBN = "2345-6", AuthorId = 3 },
                new BookAuthor { ISBN = "666-6", AuthorId = 2 }
            };

        static public List<Status> statuses = new List<Status>
            {
                new Status { Id = 1, status = "Available" },
                new Status { Id = 2, status = "Borrowed" },
                new Status { Id = 3, status = "Ordered from bookstore" },
                new Status { Id = 4, status = "Reference copy" },
                new Status { Id = 5, status = "Unknown" },
            };

        static public List<Copy> copies = new List<Copy>
            {
                new Copy { BarCode = "12345", Library = "Huvudbiblioteket", Location = "Översta hyllan", Status = statuses.ElementAt(0) },
                new Copy { BarCode = "23456", Library = "Huvudbiblioteket", Location = "Nedersta hyllan", Status = statuses.ElementAt(0) },
                new Copy { BarCode = "34567", Library = "Huvudbiblioteket", Location = "", Status = statuses.ElementAt(1) },
                new Copy { BarCode = "45678", Library = "Huvudbiblioteket", Location = "", Status = statuses.ElementAt(1) }
            };

        static public List<Book> books = new List<Book>
            {
                new Book { ISBN = "1234-5", Title = "Stora boken om bananer",
                    Classification = classifications.ElementAt(1), PublicationYear = "1920",
                    PublicationInfo = "Kalles förlag", Pages = 2897,
                    Copies = new List<Copy> { copies.ElementAt(0), copies.ElementAt(1) }
                },
                new Book { ISBN = "2345-6", Title = "Stora boken om chokladponnyer",
                    Classification = classifications.ElementAt(2), PublicationYear = "1720",
                    PublicationInfo = "Roliga timmen", Pages = 8,
                    Copies = new List<Copy> { copies.ElementAt(2) }
                },
                new Book { ISBN = "666-6", Title = "Stora boken om Satan",
                    Classification = classifications.ElementAt(0), PublicationYear = "1820",
                    PublicationInfo = "Svära i kyrkan förlag AB", Pages = 666,
                    Copies = new List<Copy> { copies.ElementAt(3) }
                }
            };

        static public List<Category> categories = new List<Category>
        {
            new Category{ Id=1, CategoryName="Extern", Period=30, PenaltyPerDay=5},
            new Category{ Id=2, CategoryName="Personal", Period=40, PenaltyPerDay=0},
            new Category{ Id=3, CategoryName="Studerande", Period=60, PenaltyPerDay=1},
            new Category{ Id=4, CategoryName="Barn", Period=30, PenaltyPerDay=0}
        };

        static public List<Loan> loans = new List<Loan>
        {
            new Loan { BarCode = "34567", BorrowDate = new DateTime(2016, 1, 15), ReturnDate = null, ToBeReturnedDate = new DateTime(2016, 3, 15) },
            new Loan { BarCode = "45678", BorrowDate = new DateTime(2016, 2, 1), ReturnDate = null, ToBeReturnedDate = new DateTime(2016, 4, 1) }
        };

        static public List<Borrower> borrowers = new List<Borrower>
        {
            new Borrower{PersonId="19111111-1111",LastName="Elvansson", FirstName="Elvan", Adress="Älvv.11 11111 Älvstad", TelephoneNumber="0111-111111", CategoryId=1, Loans=null},
            new Borrower{PersonId="19121212-1212",LastName="Tolvansson", FirstName="Tolvan", Adress="Tolvv.12 12121 Tolvstad", TelephoneNumber="0121-121212", CategoryId=2, Loans = new List<Loan> { loans.ElementAt(0), loans.ElementAt(1) } }
        };

    }
}
