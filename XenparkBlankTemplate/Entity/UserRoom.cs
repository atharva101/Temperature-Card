using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace XenparkBlankTemplate.Entity
{
    public partial class UserRoom
    {
        public int Id { get; set; }
        public int? UserId { get; set; }
        public int? RoomId { get; set; }
        public virtual User User { get; set; }
    }
}
