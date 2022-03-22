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
    [AllowAnonymous]
    public class BatchController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IErrorLogService _errorLogService;
        private readonly XPDbContext context;

        public BatchController(IUserService userService,
                              IErrorLogService errorLogService,
                              XPDbContext db)
        {
            _userService = userService;
            _errorLogService = errorLogService;
            this.context = db;
        }

        [HttpGet]
        public List<Batch> GetBatch(Boolean readyToAssign = false, int roomId = 0)
        {

            List<Batch> batchs = new List<Batch>();
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetBatch", sqlConnection))
                    {
                        
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ReadyToAssign", readyToAssign);
                        cmd.Parameters.AddWithValue("@RoomId", roomId);
                        DataSet data = new DataSet();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(data);

                        if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                        {
                            DataTable dtBatch = data.Tables[0];
                            for (int i = 0; i < dtBatch.Rows.Count; i++)
                            {
                                Batch b = new Batch();
                                b.Id = Convert.ToInt32(dtBatch.Rows[i]["Id"]);
                                b.ProductId = Convert.ToInt32(dtBatch.Rows[i]["ProductId"]);
                                b.BatchNumber = dtBatch.Rows[i]["BatchNumber"].ToString();
                                b.BatchSize = Convert.ToInt32(dtBatch.Rows[i]["BatchSize"]);
                                b.Status = dtBatch.Rows[i]["Status"].ToString();
                                b.Approved = Convert.ToBoolean(dtBatch.Rows[i]["Approved"]);
                                batchs.Add(b);

                                b.BatchLogger = new List<BatchLogger>();
                                if (data.Tables.Count > 1 && data.Tables[1].Rows.Count > 0)
                                {
                                    if (data.Tables[1].Select("BatchId =" + b.Id.ToString()).Count() > 0)
                                    {
                                        foreach (var row in (data.Tables[1].Select("BatchId =" + b.Id.ToString())))
                                        {
                                            b.BatchLogger.Add(new BatchLogger()
                                            {
                                                Id = Convert.ToInt32(row["Id"]),
                                                BatchId = Convert.ToInt32(row["BatchId"]),
                                                RoomId = Convert.ToInt32(row["RoomId"]),
                                                TimeStamp = null
                                            });
                                        }

                                    }
                                }
                            }
                        }
                    }
                    sqlConnection.Close();
                }

                return batchs;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpGet]
        public List<Batch> GetAvailableBatch(int roomId)
        {

            List<Batch> batchs = new List<Batch>();
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetAvailableBatches", sqlConnection))
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@RoomId", roomId);
                        DataSet data = new DataSet();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(data);

                        if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                        {
                            DataTable dtBatch = data.Tables[0];
                            for (int i = 0; i < dtBatch.Rows.Count; i++)
                            {
                                Batch b = new Batch();
                                b.Id = Convert.ToInt32(dtBatch.Rows[i]["Id"]);
                                b.ProductId = Convert.ToInt32(dtBatch.Rows[i]["ProductId"]);
                                b.BatchNumber = dtBatch.Rows[i]["BatchNumber"].ToString();
                                b.BatchSize = Convert.ToInt32(dtBatch.Rows[i]["BatchSize"]);
                                b.Status = dtBatch.Rows[i]["Status"].ToString();
                                b.Approved = Convert.ToBoolean(dtBatch.Rows[i]["Approved"]);
                                batchs.Add(b);
                            }
                        }
                    }
                    sqlConnection.Close();
                }

                return batchs;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }


        [HttpPost]
        public int AddEditBatch(Batch batch)
        {
            int returnValue = -101;
            try
            { 
                int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sprocAddEditBatch", sqlConnection))
                    {
                        sqlConnection.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Id", batch.Id);
                        if (batch.BatchLogger != null && batch.BatchLogger.Count > 0)
                            cmd.Parameters.AddWithValue("@RoomIds", String.Join(',', batch.BatchLogger.Select(x => x.RoomId).ToArray()));
                        else
                            cmd.Parameters.AddWithValue("@RoomIds", "");
                        cmd.Parameters.AddWithValue("@ProductId", batch.ProductId);
                        cmd.Parameters.AddWithValue("@BatchNumber", batch.BatchNumber);
                        cmd.Parameters.AddWithValue("@BatchSize", batch.BatchSize);
                        cmd.Parameters.AddWithValue("@Status", batch.Status ?? "Not Started");
                        cmd.Parameters.AddWithValue("@UserId", userID);
                        cmd.Parameters.Add("@ReturnValue", SqlDbType.Int);
                        cmd.Parameters["@ReturnValue"].Direction = ParameterDirection.Output;

                        cmd.ExecuteNonQuery();
                        returnValue = Convert.ToInt32(cmd.Parameters["@ReturnValue"].Value);
                        sqlConnection.Close();
                    }

                }
                return returnValue;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return -501;
            }
        }

        [HttpGet]
        public void AssignBatchToRoom(int batchId, int roomId)
        {
            try
            {
                int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sprocAssignBatchToRoom", sqlConnection))
                    {
                        sqlConnection.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@BatchId", batchId);
                        cmd.Parameters.AddWithValue("@RoomId", roomId);
                        cmd.ExecuteNonQuery();
                        sqlConnection.Close();
                    }

                }
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
            }
        }

        [HttpGet]
        public int CompleteBatch(string batchIds)
        {
            try
            {
                int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sprocCompleteBatch", sqlConnection))
                    {
                        sqlConnection.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@BatchIds", batchIds);
                        cmd.ExecuteNonQuery();
                        sqlConnection.Close();
                        return 101;
                    }
                }
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return -1;
            }
        }
    }
}