using System;
using System.Collections.Generic;

namespace XenparkBlankTemplate.Entity
{
    public partial class ErrorLog
    {
        public int Id { get; set; }
        public DateTime? Date { get; set; }
        public string Message { get; set; }
        public string StackTrace { get; set; }
        public string Source { get; set; }
        public string TargetSite { get; set; }
        public int? userId { get; set; }
    }
}
