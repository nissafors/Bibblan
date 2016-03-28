using System.Collections.Generic;

namespace Repository.EntityModels
{
    /// <summary>
    /// Different Roles for access to diffent parts of the website
    /// </summary>
    public class UserRole
    {
        public int Id {get; set;}
        public string  Role { get; set; }
    }
}
