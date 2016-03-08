using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Models
{
    public class AccountViewModel
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public int RoleId { get; set; }
        public string PersonId { get; set; }
    }
}
