export interface IBatch {
    Select: boolean;
    Id: number;
    ProductId: number;
    BatchNumber: string;
    BatchSize: number;
    UOM: string;
    Status: string;
    AddedBy: number;
    AddedOn: string | null;
    UpdatedBy: number;
    UpdatedOn: string | null;
    BatchLogger: IBatchLogger[];
    Approved: boolean;
}

export interface IBatchLogger {
    Id: number;
    BatchId: number;
    RoomId: number;
    TimeStamp: string | null;

}