using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace XenparkBlankTemplate.Models
{
    public class DashboardData
    {
        public List<BatchInformation> BatchInformation { get; set; }
        public List<DownTimeInfo> Downtime { get; set; }

        public List<UnitPriceInfo> UnitPrice { get; set; }

        public List<MachineNotification> Notifications { get; set; }
    }

    public class MachineNotification
    {
        public int MachineId { get; set; }
        public DateTime? TimeStamp { get; set; }
        public string MachineStatus { get; set; }
        public string DowntimeReason { get; set; }
    }
    public class UnitPriceInfo
    {
        public double Rent { get; set; }
        public double Salaries { get; set; }
        public double TaxesInsurance { get; set; }
        public double RMCost { get; set; }
        public double LaborPU { get; set; }
        public double OilCost { get; set; }

        public double GasCost { get; set; }
        public double WaterCost { get; set; }

        public double ElectricityCost { get; set; }
        public double ShippingCost { get; set; }

    }
    public class DownTimeInfo
    {
        public DateTime? StopTimeStamp { get; set; }
        public DateTime? ResumeTimeStamp { get; set; }
        public string Topic { get; set; }
        public string BatchNumber { get; set; }
        public string Shift { get; set; }
        public string Data { get; set; }
        public string DownTimeReason { get; set; }
        public double DownTime { get; set; }
    }
    public class BatchInformation
    {
        public int MachineId { get; set; }
        public int ProductId { get; set; }
        public int OperatorCode { get; set; }
        public int Rejection { get; set; }
        public string BatchNumber { get; set; }
        public decimal SetProduction { get; set; }
        public decimal SetEfficiency { get; set; }
        public decimal SetUtilization { get; set; }
        public decimal TargetTime { get; set; }
        public bool? Active { get; set; }
        public DateTime BatchStartTime { get; set; }
        public DateTime? BatchEndTime { get; set; }
        public decimal ActualProduction { get; set; }
        public bool BatchFinished { get; set; }
        public string Shift { get; set; }
        public decimal ActualRawMaterialConsumption { get; set; }

        public decimal ActualOilConsumption { get; set; }
        public decimal ActualGasConsumption { get; set; }
        public decimal ActualWaterConsumption { get; set; }
        public decimal ActualPowerConsumption { get; set; }

        public decimal RawMaterialRequired { get; set; }
        public decimal BudgetOilConsumption { get; set; }
        public decimal BudgetGasConsumption { get; set; }
        public decimal BudgetWaterConsumption { get; set; }
        public decimal BudgetPowerConsumption { get; set; }


    }
    public class PlantHistory
    {
        public DateTime? DateOEE { get; set; }
        public decimal? OEE { get; set; }
        public decimal? Availibility { get; set; }
        public decimal? Performance { get; set; }
        public decimal? Quality { get; set; }
        public decimal? DownTime { get; set; }
        public decimal? TargetProduction { get; set; }
        public decimal? ActualProduction { get; set; }
        public decimal? TargetEfficiency { get; set; }
        public decimal? ActualEfficiency { get; set; }
        public decimal? TargetUtilization { get; set; }
        public decimal? ActualUtilization { get; set; }
        public decimal? Fault { get; set; }
    }

    public class PlantDownTimeHistory
    {
        public DateTime? Date { get; set; }
        public string DownTimeReason { get; set; }
        public decimal? DownTime { get; set; }
    }

}
