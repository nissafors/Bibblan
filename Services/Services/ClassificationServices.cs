using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Models;
using Repository.EntityModels;

namespace Services.Services
{
    public class ClassificationServices
    {
        public static Dictionary<int, string> GetClassificationsAsDictionary()
        {
            var dic = new Dictionary<int, string>();
            List<Classification> cl;

            if (Classification.GetClassifications(out cl))
                foreach (Classification c in cl)
                    dic.Add(c.SignId, c.Signum);

            return dic;
        }

        //public static Classification GetClassification(int id)
        //{
        //    if (id == 0)
        //        return new Classification { Id = -1 };
        //    return Mockup.Mockup.classifications[id - 1];
        //}
    }
}
