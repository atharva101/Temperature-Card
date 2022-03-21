using System;
using System.Collections.Generic;

namespace XenparkBlankTemplate.Entity
{
    public partial class MachineOnOff
    {
        public int Id { get; set; }
        public DateTime? TimeStamp { get; set; }
        public string Topic { get; set; }
        public string BatchNumber { get; set; }
        public string Data { get; set; }
        public string DowntimeReason { get; set; }
    }
}
