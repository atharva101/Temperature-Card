using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace XenparkBlankTemplate.Models
{
    public class AppSetting
    {
        public string Secret { get; set; }

        public string EmailHostServer { get; set; }
        public string EmailPort { get; set; }
        public string EmailUser { get; set; }
        public string EmailPassword { get; set; }
        public string EmailFrom { get; set; }
    }

    public class NotifyMessage
    {
        public string Message { get; set; }
    }
}
