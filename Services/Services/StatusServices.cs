using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Repository.EntityModels;

namespace Services.Services
{
    public class StatusServices
    {
        public static Dictionary<int, string> GetStatusesAsDictionary()
        {
            var dic = new Dictionary<int, string>();
            List<Status> sts;

            if (Status.GetStatuses(out sts))
                foreach (Status st in sts)
                    dic.Add(st.StatusId, st.StatusName);
            
            return dic;
        }

        /*
        public static List<Status> GetStatuses()
        {
            return Mockup.Mockup.statuses;
        }

        public static Status GetStatus(int id)
        {
            return Mockup.Mockup.statuses.ElementAt(id - 1);
        }
        */
    }
}
