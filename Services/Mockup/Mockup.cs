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
                new Classification{ Description="Skönlitteratur", Id=1, Signum="Hce"},
                new Classification{ Description="Ingen koll", Id=2, Signum="Que"},
                new Classification{ Description="Hästar", Id=3, Signum="O"}
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

    }
}
