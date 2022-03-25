export interface IMaster {
    Id: number;
    Code: string;
    Description: string;
    ParentId: number;
    ParentCode: string;
    ParentDescription: string;
    Approved: boolean;
    Column1:string; // UOM for Product, IP Address for Room
    Column2:string;
    Column3:string;
    IsUsed: boolean;
}

export interface IRoomMaster {
    RoomId: number;
    RoomCode: string;
    RoomDescription: string;
    AreaId: number;
    AreaCode: string;
    AreaDescription: string;
    BlockId: number;
    BlockCode: string;
    BlockDescription: string;
    PlantId: number;
    PlantName: string;
    PlantLocation: string;
}

