using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace XenparkBlankTemplate.Entity
{
    public class RoomMaster
    {
        public int RoomId { get; set; }
        public string RoomCode { get; set; }
        public string RoomDescription { get; set; }
        public int AreaId { get; set; }
        public string AreaCode { get; set; }
        public string AreaDescription { get; set; }
        public int BlockId { get; set; }
        public string BlockCode { get; set; }
        public string BlockDescription { get; set; }
        public int PlantId { get; set; }
        public string PlantName { get; set; }
        public string PlantLocation { get; set; }
    }
}
