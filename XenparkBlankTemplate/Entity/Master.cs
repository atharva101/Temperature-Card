public partial class Master
{
    public int Id { get; set; }
    public string Code { get; set; }
    public string Description { get; set; }
    public string Column1 { get; set; }
    public string Column2 { get; set; }
    public string Column3 { get; set; }
    public int ParentId { get; set; }
    public string ParentCode { get; set; }
    public string ParentDescription { get; set; }
    public bool Approved { get; set; }
}