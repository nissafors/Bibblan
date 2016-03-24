using System;

namespace Common.Models
{
    public class BorrowViewModel
    {
        public string Title { get; set; }
        public string Barcode { get; set; }
        public string PersonId { get; set; }
        public DateTime BorrowDate { get; set; }
        public DateTime ToBeReturnedDate { get; set; }
        public DateTime ReturnDate { get; set; }

        public String BorrowDateString
        {
            get { return BorrowDate.ToString("yyyy-MM-dd"); }
        }
        public String ToBeReturnedDateString
        {
            get { return BorrowDate.ToString("yyyy-MM-dd"); }
        }
        public String ReturnDateString
        {
            get { return BorrowDate.ToString("yyyy-MM-dd"); }
        }
    }
}