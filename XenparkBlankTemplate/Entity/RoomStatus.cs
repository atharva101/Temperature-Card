using System;
using System.Collections.Generic;

public partial class RoomStatus
{
    public int RoomId { get; set; }
    public string RoomCode { get; set; }
    public string RoomDesc { get; set; }
    public int ProductId { get; set; }
    public string ProductCode { get; set; }
    public string ProductDesc { get; set; }
    public int BatchId { get; set; }
    public string BatchNumber { get; set; }
    public int BatchSize { get; set; }
    public int RoomStatusId { get; set; }
    public string RoomCurrentStatus { get; set; }
    public int RoomStatusOrder { get; set; }
    public DateTime? TimeStamp { get; set; }

    public List<RoomLog> RoomLogs = new List<RoomLog>();
}