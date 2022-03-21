using System;
using System.Collections.Generic;

namespace XenparkBlankTemplate.Entity
{
    public partial class User
    {
        public User()
        {
            LoginInfo = new HashSet<LoginInfo>();
        }

        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string UserName { get; set; }
        public int? RoleId { get; set; }
        public bool? IsDisabled { get; set; }
        public bool? IsDeleted { get; set; }

        public virtual ICollection<LoginInfo> LoginInfo { get; set; }
    }
}
