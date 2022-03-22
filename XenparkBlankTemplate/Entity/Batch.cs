using System;
using System.Collections.Generic;

public partial class Batch
{
    public int Id { get; set; }
    public int ProductId { get; set; }
    public string BatchNumber { get; set; }
    public int BatchSize { get; set; }
    public string UOM { get; set; }
    public string Status { get; set; }
    public int AddedBy { get; set; }
    public DateTime? AddedOn { get; set; }
    public int UpdatedBy { get; set; }
    public DateTime? UpdatedOn { get; set; }
    public bool Approved { get; set; }
    public List<BatchLogger> BatchLogger { get; set; }
}

public partial class BatchLogger
{
    public int Id { get; set; }
    public int BatchId { get; set; }
    public int RoomId { get; set; }
    public DateTime? TimeStamp { get; set; }
}


