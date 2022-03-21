using XenparkBlankTemplate.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace XenparkBlankTemplate.Models
{
    public class Email
    {
        public string To { get; set; }
        public string Cc { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }
        public User User { get; set; }
        public string Case { get; set; }
    }
}
