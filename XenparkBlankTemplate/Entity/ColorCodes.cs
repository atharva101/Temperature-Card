using System;
using System.Collections.Generic;

namespace XenparkBlankTemplate.Entity
{
    public partial class ColorCodes
    {
        public int Id { get; set; }
        public int? Value { get; set; }
        public string HexCode { get; set; }
        public int? ObjId { get; set; }
        public string FontColor { get; set; }
    }
}
