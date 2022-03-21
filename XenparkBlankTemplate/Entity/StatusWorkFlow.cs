using System;

public partial class StatusWorkFlow
{
    public int Id { get; set; }
    public string Status { get; set; }
    public int Order { get; set; }
    public bool IsFinal { get; set; }
    public bool Approved { get; set; }
}