using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Models;
using System.Web.Mvc;
using Services.Services;

namespace Bibblan.ViewModels
{
    public class EditCopyViewModel
    {
        StatusServices statusServices = new StatusServices();

        EditCopyViewModel()
        {
            statuses = new SelectList(statusServices.GetStatuses(), "Id", "StatusName");
        }

        EditCopyViewModel(Copy copy) : this()
        {
            this.BarCode = copy.BarCode;
            this.Location = copy.Location;
            this.StatusId = copy.Status.Id;
            this.Library = copy.Library;
        }

        public string BarCode { get; set; }
        public string Location { get; set; }
        public int StatusId { get; set; }
        public string Library { get; set; }

        public SelectList statuses { get; set; }
    }
}