using System;
using System.Collections.Generic;

namespace XenparkBlankTemplate.Entity
{
    public partial class MachineMaster
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Category { get; set; }
        public string Type { get; set; }
        public string Name { get; set; }
        public string OEM { get; set; }
        public string OEMNumber { get; set; }
        public bool? Active { get; set; }
        public int? Status { get; set; }
    }
}
