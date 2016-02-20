using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
namespace Services.Services
{
    public class ClassificationServices
    {
        public static List<Classification> getClassifications()
        {
            return Mockup.Mockup.classifications;
        }

        public static Classification getClassification(int id)
        {
            return Mockup.Mockup.classifications[id - 1];
        }
    }
}
