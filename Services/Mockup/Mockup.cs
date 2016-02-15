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
        static public List<Classification> cList = new List<Classification>
            {
                new Classification{ Description="Test1", Id=1, Signum="Test1"},
                new Classification{ Description="Test2", Id=2, Signum="Test2"},
                new Classification{ Description="Test3", Id=3, Signum="Test3"}
            };
    }
}
