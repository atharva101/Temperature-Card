using System;

public partial class RoomLog
{
    public int RoomId { get; set; }
    public int RoomStatusId { get; set; }
    public string RoomStatus { get; set; }
    public int RoomStatusOrder { get; set; }
    public DateTime? TimeStamp { get; set; }
    public int BatchId { get; set; }
    public int BatchSize { get; set; }
    public string UOM { get; set; }
    public string UserName { get; set; }
}