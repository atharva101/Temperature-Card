using XenparkBlankTemplate.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace XenparkBlankTemplate.Models
{
    public class Token
    {
        public string access_token { get; set; }
        public string token { get; set; }
        public string token_type { get; set; }
        public int expires_in { get; set; }
        public int ResponseCode { get; set; }
    }
    public class LoggedInUser
    {
        public string LoginType { get; set; }
        public string Email { get; set; }
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public int RoleId { get; set; }
        public string Token { get; set; }

        public int ResponseCode { get; set; }
    }

    public class KeyValuePair
    {
        public int Id { get; set; }
        public string Value { get; set; }
    }
}
