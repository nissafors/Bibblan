using System;

namespace Common.Models
{
    // Not used by any view. Is it a viewmodel then?
    public class BorrowViewModel
    {
        public string Title { get; set; }
        public string Barcode { get; set; }
        public string PersonId { get; set; }
        public DateTime BorrowDate { get; set; }
        public DateTime ToBeReturnedDate { get; set; }
        public DateTime ReturnDate { get; set; }
    }
}
