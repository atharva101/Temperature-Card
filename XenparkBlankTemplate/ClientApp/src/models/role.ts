export interface IRole {
    Id: number;
    Name: string;
    Description: string;
    Approved: boolean;
    RolePermission: RolePermission[];
}

export interface IPermission {
    Id: number;
    PermissionName: string;
    GroupName: string;
    checked: boolean;
}
export interface IPermissionGroup {
    GroupName: string;
    Permission: IPermission[];
}

export interface RolePermission {
    Id: number;
    RoleId: number;
    PermissionId: number;
}