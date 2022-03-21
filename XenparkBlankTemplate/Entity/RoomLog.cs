using System;

public partial class RoomLog
{
    public int RoomId { get; set; }
    public int RoomStatusId { get; set; }
    public string RoomStatus { get; set; }
    public int RoomStatusOrder { get; set; }
    public DateTime? TimeStamp { get; set; }
    public DateTime? ToTimeStamp { get; set; }
    public bool IsFinal { get; set; }
    public bool IsPrev { get; set; }
    public bool IsCurrent { get; set; }
    public bool IsNext { get; set; }
}