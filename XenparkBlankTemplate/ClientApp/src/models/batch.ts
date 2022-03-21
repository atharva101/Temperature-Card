export interface IBatch {
    Id: number;
    ProductId: number;
    BatchNumber: string;
    BatchSize: number;
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