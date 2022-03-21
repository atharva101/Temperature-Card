using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace XenparkBlankTemplate.Controllers
{
    public partial class Role
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public bool SysRole { get; set; }
        public bool Approved { get; set; }
        public List<RolePermission> RolePermission { get; set; }

    }

    public partial class Permission
    {
        public int Id { get; set; }
        public string PermissionName { get; set; }
        public string GroupName { get; set; }
    }

    public partial class RolePermission
    {
        public int Id { get; set; }
        public int RoleId { get; set; }
        public int PermissionId { get; set; }
    }

}
