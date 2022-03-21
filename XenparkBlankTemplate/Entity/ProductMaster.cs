using System;
using System.Collections.Generic;

namespace XenparkBlankTemplate.Entity
{
    public partial class ProductMaster
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public bool? Active { get; set; }
        public bool Approved { get; set; }
    }
}
