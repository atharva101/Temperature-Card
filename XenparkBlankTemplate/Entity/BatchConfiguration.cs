using System;
using System.Collections.Generic;

namespace XenparkBlankTemplate.Entity
{
    public partial class BatchConfiguration
    {
        public int Id { get; set; }
        public int MachineId { get; set; }
        public int ProductId { get; set; }
        public int OperatorCode { get; set; }
        public string BatchNumber { get; set; }
        public decimal SetProduction { get; set; }
        public decimal SetEfficiency { get; set; }
        public decimal SetUtilization { get; set; }
        public bool? Active { get; set; }
        public decimal? TargetTime { get; set; }
        public int? Rejection { get; set; }
         public decimal ActualRawMaterialConsumption {get;set;}
         public decimal   ActualOilConsumption{get;set;}
        public decimal ActualGasConsumption{get;set;}
        public decimal ActualWaterConsumption{get;set;}
        public decimal ActualPowerConsumption{get;set;} 

        public decimal BudgetOilConsumption{get;set;}
        public decimal BudgetGasConsumption{get;set;}
        public decimal BudgetWaterConsumption{get;set;}
        public decimal BudgetPowerConsumption{get;set;}
        

        

    }
}
