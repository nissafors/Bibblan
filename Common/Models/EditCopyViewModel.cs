using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Models;
using System.Web.Mvc;
using Services.Services;

namespace Bibblan.Models
{
    public class EditCopyViewModel
    {
        public EditCopyViewModel()
        {
            Statuses = new SelectList(StatusServices.GetStatuses(), "Id", "StatusName");
        }

        public EditCopyViewModel(Copy copy) : this()
        {
            this.BarCode = copy.BarCode;
            this.Location = copy.Location;
            this.StatusId = copy.Status.Id;
            this.Library = copy.Library;
            this.ISBN = copy.Book.ISBN;
        }

        public Copy ToCopy()
        {
            var copy = new Copy();
            copy.BarCode = this.BarCode;
            copy.Location = this.Location;
            copy.Status = StatusServices.GetStatus(this.StatusId);
            copy.Library = this.Library;
            copy.Book = BookServices.GetBookFromISBN(this.ISBN);

            return copy;
        }

        public string BarCode { get; set; }
        public string Location { get; set; }
        public int StatusId { get; set; }
        public string Library { get; set; }
        public string ISBN { get; set; }

        public SelectList Statuses { get; set; }
    }
}