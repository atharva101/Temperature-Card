public partial class Master
{
    public int Id { get; set; }
    public string Code { get; set; }
    public string Description { get; set; }
    public int ParentId { get; set; }
    public string ParentCode { get; set; }
    public string ParentDescription { get; set; }
    public bool Approved { get; set; }
}