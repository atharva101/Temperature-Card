using System;
using System.Collections.Generic;

namespace XenparkBlankTemplate.Entity
{
    public partial class LoginInfo
    {
        public int Id { get; set; }
        public int? UserId { get; set; }
        public string Password { get; set; }
        public int? IncorrectAttempt { get; set; }
        public DateTime? LastLogInTime { get; set; }
        public bool? Blocked { get; set; }
        public bool ForceChangePassword { get; set; }

        public virtual User User { get; set; }
    }
}
