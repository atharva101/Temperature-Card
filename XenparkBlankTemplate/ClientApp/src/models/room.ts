export interface IRoom {
    id: number;
    RoomId: number;
    RoomCode: string;
    RoomDesc: string;
    ProductId: number;
    ProductCode: string;
    ProductDesc: string;
    BatchId: number;
    BatchNumber: string;
    BatchSize: number;
    UOM: string;
    RoomStatusId: number;
    RoomCurrentStatus: string;
    RoomStatusOrder: number;
    TimeStamp: string | null;
    RoomLogs: RoomLog[];
    Product: string | null;
}

export interface RoomLog {
    RoomId: number;
    RoomStatusId: number;
    RoomStatus: string;
    RoomStatusOrder: number;
    TimeStamp: string | null;
    ToTimeStamp: string | null;
    IsFinal: boolean;
    IsPrev: boolean;
    IsCurrent: boolean;
    IsNext: boolean;
}
