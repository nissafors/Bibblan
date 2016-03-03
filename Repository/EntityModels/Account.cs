using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.EntityModels
{
    public class Account
    {
        public enum Status {Admin, User}
        public string UserName {get; set;}
        public string PersonId { get; set; }
        public Status getStatus()
        {
            /*
            SqlCommand command = new SqlCommand("SELECT status from ACCOUNT WHERE username = @username");
            command.Parameters.AddWithValue("username", this.UserName);
            return new Status[]
            */
            return Status.Admin;
        }

        public static bool getAccount(out Account, string username, string hash)
        {

            //return false;
        }



    }
}
