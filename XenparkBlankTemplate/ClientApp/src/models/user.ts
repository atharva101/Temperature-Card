import { IRoomMaster } from "./master";

export interface IUser {
    Id: number;
    FirstName: string;
    LastName: string;
    Email: string;
    UserName: string;
    RoleId: number | null;
    IsDisabled: boolean | null;
    IsDeleted: boolean | null;
    Avatar: string,
    UserRooms: IUserRoom[]
}

export interface IUserRoom {
    Id: number;
    UserId: number;
    RoomId: number;
}