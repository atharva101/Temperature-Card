using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace XenparkBlankTemplate.Entity
{
    public class Menu
    {        
        public int Id { get; set; }        
        public string Title { get; set; }        
        public string Type { get; set; }        
        public string URL { get; set; }        
        public string Icon { get; set; }        
        public bool? Target { get; set; }        
        public bool? Breadcrumbs { get; set; }               
        public string Classes { get; set; }        
        public int? ParentId { get; set; } 
        public List<Menu> Children { get; set; }
    }
}
