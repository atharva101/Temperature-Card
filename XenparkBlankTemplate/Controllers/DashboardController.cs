using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using XenparkBlankTemplate.Models;
using XenparkBlankTemplate.Services;
using XenparkBlankTemplate.Helper;
using XenparkBlankTemplate.Entity;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Data;
using System.Data;
using System.Security.Claims;

namespace XenparkBlankTemplate.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [Authorize]
    public class DashboardController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IErrorLogService _errorLogService;
        private readonly XPDbContext context;
        private readonly IEmailService _emailService;

        public DashboardController(IUserService userService,
                              IErrorLogService errorLogService,
                              XPDbContext db,
                              IEmailService emailService)
        {
            _userService = userService;
            _errorLogService = errorLogService;
            this.context = db;
            _emailService = emailService;
        }

        [HttpGet]
        public DashboardData GetBatchInformation(int machineId)
        {
            DashboardData dashboardData = new DashboardData();
            int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);

            try
            {
                using SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString);
                using SqlCommand cmd = new SqlCommand("sprocGetBatchInformation", sqlConnection);
                DataSet data = new DataSet();
                sqlConnection.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MachineId", machineId);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(data);
                if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                {
                    dashboardData.BatchInformation = new List<BatchInformation>();
                    DataTable dtBatchInfo = data.Tables[0];
                    for (int i = 0; i < dtBatchInfo.Rows.Count; i++)
                    {
                        BatchInformation bi = new BatchInformation
                        {
                            MachineId = Convert.ToInt32(dtBatchInfo.Rows[i]["MachineId"]),
                            ProductId = Convert.ToInt32(dtBatchInfo.Rows[i]["ProductId"]),
                            OperatorCode = Convert.ToInt32(dtBatchInfo.Rows[i]["OperatorCode"]),
                            Rejection = Convert.ToInt32(dtBatchInfo.Rows[i]["Rejection"]),
                            BatchNumber = dtBatchInfo.Rows[i]["BatchNumber"].ToString(),
                            SetProduction = Convert.ToDecimal(dtBatchInfo.Rows[i]["SetProduction"]),
                            SetEfficiency = Convert.ToDecimal(dtBatchInfo.Rows[i]["SetEfficiency"]),
                            SetUtilization = Convert.ToDecimal(dtBatchInfo.Rows[i]["SetUtilization"]),
                            TargetTime = Convert.ToDecimal(dtBatchInfo.Rows[i]["TargetTime"]),
                            Active = Convert.ToBoolean(dtBatchInfo.Rows[i]["Active"]),
                            BatchStartTime = Convert.ToDateTime(dtBatchInfo.Rows[i]["BatchStartTime"]),
                            BatchEndTime = dtBatchInfo.Rows[i]["BatchEndTime"] == DBNull.Value ? new DateTime(1900, 1, 1) : Convert.ToDateTime(dtBatchInfo.Rows[i]["BatchEndTime"]),
                            ActualProduction = dtBatchInfo.Rows[i]["ActualProduction"] == DBNull.Value ? 0 : Convert.ToDecimal(dtBatchInfo.Rows[i]["ActualProduction"]),
                            BatchFinished = Convert.ToBoolean(dtBatchInfo.Rows[i]["BatchFinished"]),
                            Shift = dtBatchInfo.Rows[i]["Shift"].ToString(),
                            ActualRawMaterialConsumption = Convert.ToDecimal(dtBatchInfo.Rows[i]["ActualRawMaterialConsumption"]),
                            ActualOilConsumption = Convert.ToDecimal(dtBatchInfo.Rows[i]["ActualOilConsumption"]),
                            ActualGasConsumption = Convert.ToDecimal(dtBatchInfo.Rows[i]["ActualGasConsumption"]),
                            ActualWaterConsumption = Convert.ToDecimal(dtBatchInfo.Rows[i]["ActualWaterConsumption"]),
                            ActualPowerConsumption = Convert.ToDecimal(dtBatchInfo.Rows[i]["ActualPowerConsumption"]),
                            RawMaterialRequired = Convert.ToDecimal(dtBatchInfo.Rows[i]["RawMaterialRequired"]),
                            BudgetOilConsumption = Convert.ToDecimal(dtBatchInfo.Rows[i]["BudgetOilConsumption"]),
                            BudgetGasConsumption = Convert.ToDecimal(dtBatchInfo.Rows[i]["BudgetGasConsumption"]),
                            BudgetWaterConsumption = Convert.ToDecimal(dtBatchInfo.Rows[i]["BudgetWaterConsumption"]),
                            BudgetPowerConsumption = Convert.ToDecimal(dtBatchInfo.Rows[i]["BudgetPowerConsumption"]),


                        };
                        dashboardData.BatchInformation.Add(bi);
                    }
                    
                    DataTable dtDowntime = data.Tables[1];
                    dashboardData.Downtime = new List<DownTimeInfo>();
                    for (int i = 0; i < dtDowntime.Rows.Count; i++)
                    {
                        DownTimeInfo dt = new DownTimeInfo
                        {
                            StopTimeStamp = null,// Convert.ToDateTime(dtDowntime.Rows[i]["StopTimeStamp"]),
                            ResumeTimeStamp = null, // dtDowntime.Rows[i]["ResumeTimeStamp"] == DBNull.Value ? null : Convert.ToDateTime(dtDowntime.Rows[i]["ResumeTimeStamp"]),
                            Topic = dtDowntime.Rows[i]["Topic"].ToString(),
                            BatchNumber = dtDowntime.Rows[i]["BatchNumber"].ToString(),
                            Shift = dtDowntime.Rows[i]["Shift"].ToString(),
                            Data = dtDowntime.Rows[i]["Data"].ToString(),
                            DownTimeReason = dtDowntime.Rows[i]["DownTimeReason"].ToString(),
                            DownTime = Convert.ToDouble(dtDowntime.Rows[i]["DownTime"]),
                        };
                        if (dtDowntime.Rows[i]["StopTimeStamp"] != DBNull.Value)
                            dt.StopTimeStamp = Convert.ToDateTime(dtDowntime.Rows[i]["StopTimeStamp"]);
                        if (dtDowntime.Rows[i]["ResumeTimeStamp"] != DBNull.Value)
                            dt.ResumeTimeStamp = Convert.ToDateTime(dtDowntime.Rows[i]["ResumeTimeStamp"]);

                        dashboardData.Downtime.Add(dt);
                    }

                    // Price Table 
                    DataTable dtUnitPrice = data.Tables[2];
                    dashboardData.UnitPrice = new List<UnitPriceInfo>();
                    for (int i = 0; i < dtUnitPrice.Rows.Count; i++)
                    {
                        UnitPriceInfo dt = new UnitPriceInfo
                        {
                            Rent = Convert.ToDouble(dtUnitPrice.Rows[i]["Rent"]),
                            Salaries = Convert.ToDouble(dtUnitPrice.Rows[i]["Salaries"]),
                            TaxesInsurance = Convert.ToDouble(dtUnitPrice.Rows[i]["TaxesInsurance"]),
                            RMCost = Convert.ToDouble(dtUnitPrice.Rows[i]["RMCost"]),
                            LaborPU = Convert.ToDouble(dtUnitPrice.Rows[i]["LaborPU"]),
                            OilCost = Convert.ToDouble(dtUnitPrice.Rows[i]["OilCost"]),
                            GasCost = Convert.ToDouble(dtUnitPrice.Rows[i]["GasCost"]),
                            WaterCost = Convert.ToDouble(dtUnitPrice.Rows[i]["WaterCost"]),
                            ElectricityCost = Convert.ToDouble(dtUnitPrice.Rows[i]["ElectricityCost"]),
                            ShippingCost = Convert.ToDouble(dtUnitPrice.Rows[i]["ShippingCost"]),


                        };

                        dashboardData.UnitPrice.Add(dt);
                    }

                    DataTable dtNotification = data.Tables[3];
                    dashboardData.Notifications = new List<MachineNotification>();
                    for (int i = 0; i < dtNotification.Rows.Count; i++)
                    {
                        MachineNotification dt = new MachineNotification
                        {
                            MachineId = Convert.ToInt32(dtNotification.Rows[i]["MachineId"].ToString()),
                            TimeStamp = null,
                            MachineStatus = dtNotification.Rows[i]["MachineStatus"].ToString(),
                            DowntimeReason = dtNotification.Rows[i]["DowntimeReason"].ToString(),                            
                        };
                        if (dtNotification.Rows[i]["TimeStamp"] != DBNull.Value)
                            dt.TimeStamp = Convert.ToDateTime(dtNotification.Rows[i]["TimeStamp"]);
                        

                        dashboardData.Notifications.Add(dt);
                    }
                }

                sqlConnection.Close();
                return dashboardData;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpGet]
        public List<ColorCodes> GetColorCodes()
        {
            return this.context.ColorCodes.ToList();
        }

        public List<PlantHistory> GetPlantHistory(int period = 7, int machineId = -1)
        {
            List<PlantHistory> ph = new List<PlantHistory>();
            try
            {
                PlantHistory p = new PlantHistory();
                using SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString);
                using SqlCommand cmd = new SqlCommand("sprocGetOEE", sqlConnection);
                DataSet dtset = new DataSet();
                sqlConnection.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Period", period);
                cmd.Parameters.AddWithValue("@MachineID", machineId > 0 ? "m" + machineId : "");
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(dtset);
                if (dtset == null || dtset.Tables.Count == 0)
                    throw new Exception("GetPlantHistory with returns incorrect resultset.");

                foreach (DataRow dtRow in dtset.Tables[0].Rows)
                {
                    ph.Add(new PlantHistory
                    {
                        DateOEE = dtRow.Field<DateTime?>("DateOEE"),
                        OEE = dtRow.Field<decimal?>("OEE"),
                        Availibility = dtRow.Field<decimal?>("Availibility"),
                        Performance = dtRow.Field<decimal?>("Performance"),
                        Quality = dtRow.Field<decimal?>("Quality"),
                        DownTime = dtRow.Field<decimal?>("DownTime"),
                        TargetProduction = dtRow.Field<decimal?>("TargetProduction"),
                        ActualProduction = dtRow.Field<decimal?>("ActualProduction"),
                        TargetEfficiency = dtRow.Field<decimal?>("TargetEfficiency"),
                        ActualEfficiency = dtRow.Field<decimal?>("ActualEfficiency"),
                        TargetUtilization = dtRow.Field<decimal?>("TargetUtilization"),
                        ActualUtilization = dtRow.Field<decimal?>("ActualUtilization"),
                        Fault = dtRow.Field<decimal?>("Fault")
                    });
                }
                return ph;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public List<PlantDownTimeHistory> GetPlantDownTimeHistory(int period = 7)
          {
            List<PlantDownTimeHistory> phd = new List<PlantDownTimeHistory>();
            try
            {
                PlantDownTimeHistory pdown = new PlantDownTimeHistory();
                using SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString);
                using SqlCommand cmd = new SqlCommand("sprocGetDownTime", sqlConnection);
                DataSet dtset = new DataSet();
                sqlConnection.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Period", period);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(dtset);
                if (dtset == null || dtset.Tables.Count == 0)
                    throw new Exception("GetPlantDownTimeHistory with returns incorrect resultset.");

                foreach (DataRow dtRow in dtset.Tables[0].Rows)
                {
                    phd.Add(new PlantDownTimeHistory
                    {
                        Date = Convert.ToDateTime(dtRow["Date"]),
                        DownTimeReason = dtRow.Field<string>("DownTimeReason"),
                        DownTime = dtRow.Field<decimal?>("DownTime")
                        
                    });
                }
                return phd;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}
