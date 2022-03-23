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
using Microsoft.AspNetCore.HttpOverrides;
using System.Net;
using System.Net.Sockets;

namespace XenparkBlankTemplate.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [AllowAnonymous]
    public class RoomController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IErrorLogService _errorLogService;
        private readonly XPDbContext context;

        public RoomController(IUserService userService,
                              IErrorLogService errorLogService,
                              XPDbContext db)
        {
            _userService = userService;
            _errorLogService = errorLogService;
            this.context = db;
        }

        [HttpGet]
        public List<RoomStatus> GetRoomStatus(int roomId = -1)
        {

            List<RoomStatus> roomStatus = new List<RoomStatus>();
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetRoomStatus", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        DataSet data = new DataSet();
                        cmd.Parameters.AddWithValue("@RoomId", roomId);
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(data);

                        if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                        {
                            DataTable dtRoomStatus = data.Tables[0];
                            for (int i = 0; i < dtRoomStatus.Rows.Count; i++)
                            {
                                RoomStatus room = new RoomStatus();
                                room.RoomId = Convert.ToInt32(dtRoomStatus.Rows[i]["RoomId"]);
                                room.RoomCode = dtRoomStatus.Rows[i]["RoomCode"].ToString();
                                room.RoomDesc = dtRoomStatus.Rows[i]["RoomDesc"].ToString();
                                room.ProductId = dtRoomStatus.Rows[i]["ProductId"] == DBNull.Value ? -1 : Convert.ToInt32(dtRoomStatus.Rows[i]["ProductId"]);
                                room.ProductCode = dtRoomStatus.Rows[i]["ProductCode"] == DBNull.Value ? "" : dtRoomStatus.Rows[i]["ProductCode"].ToString();
                                room.ProductDesc = dtRoomStatus.Rows[i]["ProductDesc"] == DBNull.Value ? "" : dtRoomStatus.Rows[i]["ProductDesc"].ToString();
                                room.BatchId = dtRoomStatus.Rows[i]["BatchId"] == DBNull.Value ? -1 : Convert.ToInt32(dtRoomStatus.Rows[i]["BatchId"]);
                                room.BatchNumber = dtRoomStatus.Rows[i]["BatchNumber"] == DBNull.Value ? "" : dtRoomStatus.Rows[i]["BatchNumber"].ToString();
                                room.BatchSize = dtRoomStatus.Rows[i]["BatchSize"] == DBNull.Value ? -1 : Convert.ToInt32(dtRoomStatus.Rows[i]["BatchSize"]);
                                room.UOM = dtRoomStatus.Rows[i]["UOM"].ToString();
                                room.RoomStatusId = dtRoomStatus.Rows[i]["RoomStatusId"] == DBNull.Value ? -1 : Convert.ToInt32(dtRoomStatus.Rows[i]["RoomStatusId"]);
                                room.RoomCurrentStatus = dtRoomStatus.Rows[i]["RoomCurrentStatus"] == DBNull.Value ? "" : dtRoomStatus.Rows[i]["RoomCurrentStatus"].ToString();
                                room.RoomStatusOrder = dtRoomStatus.Rows[i]["RoomStatusOrder"] == DBNull.Value ? -1 : Convert.ToInt32(dtRoomStatus.Rows[i]["RoomStatusOrder"]);
                                if (dtRoomStatus.Rows[i]["TimeStamp"] != DBNull.Value)
                                    room.TimeStamp = Convert.ToDateTime(dtRoomStatus.Rows[i]["TimeStamp"]);

                                // Get Room Log 
                                List<RoomLog> roomLogs = new List<RoomLog>();
                                if (data.Tables.Count > 1 && data.Tables[1].Rows.Count > 0)
                                {
                                    if (data.Tables[1].Select("RoomId =" + room.RoomId.ToString()).Count() > 0)
                                    {
                                        foreach (var row in (data.Tables[1].Select("RoomId =" + room.RoomId.ToString())))
                                        {
                                            RoomLog rl = new RoomLog();
                                            rl.RoomId = Convert.ToInt32(row["RoomId"]);
                                            rl.RoomStatusId = Convert.ToInt32(row["RoomStatusId"]);
                                            rl.RoomStatus = row["RoomStatus"].ToString();
                                            rl.RoomStatusOrder = Convert.ToInt32(row["RoomStatusOrder"]);
                                            if (row["TimeStamp"] != DBNull.Value)
                                                rl.TimeStamp = Convert.ToDateTime(row["TimeStamp"]);
                                            if (row["ToTimeStamp"] != DBNull.Value)
                                                rl.ToTimeStamp = Convert.ToDateTime(row["ToTimeStamp"]);
                                            //try
                                            //{
                                            //    rl.ToTimeStamp = Convert.ToDateTime(row["ToTimeStamp"]);
                                            //}
                                            //catch (System.Exception)
                                            //{

                                            //    rl.ToTimeStamp = null;
                                            //}
                                            rl.IsFinal = Convert.ToBoolean(row["IsFinal"]);
                                            rl.IsPrev = Convert.ToBoolean(row["IsPrev"]);
                                            rl.IsCurrent = Convert.ToBoolean(row["IsCurrent"]);
                                            rl.IsNext = Convert.ToBoolean(row["IsNext"]);
                                            roomLogs.Add(rl);
                                        }
                                    }
                                }
                                room.RoomLogs = roomLogs;

                                roomStatus.Add(room);
                            }
                        }
                    }
                    sqlConnection.Close();
                }

                return roomStatus;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpGet]
        public List<StatusWorkFlow> GetStatusWorkFlow()
        {

            List<StatusWorkFlow> status = new List<StatusWorkFlow>();
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetRoomStatusWorkFlow", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        DataSet data = new DataSet();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(data);

                        if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                        {
                            DataTable dtStatus = data.Tables[0];
                            for (int i = 0; i < dtStatus.Rows.Count; i++)
                            {
                                StatusWorkFlow swf = new StatusWorkFlow();
                                swf.Id = Convert.ToInt32(dtStatus.Rows[i]["Id"]);
                                swf.Status = dtStatus.Rows[i]["Status"].ToString();
                                swf.Order = Convert.ToInt32(dtStatus.Rows[i]["Order"]);
                                swf.IsFinal = Convert.ToBoolean(dtStatus.Rows[i]["IsFinal"]);
                                status.Add(swf);
                            }
                        }
                    }
                    sqlConnection.Close();
                }

                return status;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpGet]
        public int ChangeRoomStatus(int roomId,int batchId, int statusId)
        {
            try
            {

                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sprocChangeRoomStatus", sqlConnection))
                    {
                        sqlConnection.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@RoomId", roomId);
                        cmd.Parameters.AddWithValue("@BatchId", batchId);
                        cmd.Parameters.AddWithValue("@StatusId", statusId);
                        cmd.ExecuteNonQuery();
                        sqlConnection.Close();
                        return 501;
                    }

                }
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return -101;
            }
        }

        [HttpGet]
        public List<RoomStatus> GetRoomStatusByClientIP()
        {
            List<RoomStatus> rs = new List<RoomStatus>();
            var ip  = _userService.GetClientIP(Request.HttpContext.Connection.RemoteIpAddress);
            if (ip != "") 
            {
                // Get room Id by IP address 
                Master room = GetRoomByIPAddress(ip);

                if(room != null && room.Id > 0) 
                {
                    var statuses = GetRoomStatus(room.Id);
                    //rs = statuses.FirstOrDefault();
                }

            }
                
            return rs;
        }

        private Master GetRoomByIPAddress(string ip) 
        {
            List<Master> masters = new List<Master>();
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetRoomByIPAddress", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        DataSet data = new DataSet();
                        cmd.Parameters.AddWithValue("@IPAddress", ip);

                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(data);

                        if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                        {
                            DataTable dtMaster = data.Tables[0];
                            for (int i = 0; i < dtMaster.Rows.Count; i++)
                            {
                                Master mast = new Master();
                                mast.Id = Convert.ToInt32(dtMaster.Rows[i]["Id"]);
                                mast.Code = dtMaster.Rows[i]["Code"].ToString();
                                mast.Description = dtMaster.Rows[i]["Description"].ToString();
                                mast.ParentId = Convert.ToInt32(dtMaster.Rows[i]["ParentId"]);
                                mast.ParentCode = dtMaster.Rows[i]["ParentCode"].ToString();
                                mast.ParentDescription = dtMaster.Rows[i]["ParentDescription"].ToString();
                                mast.Approved = Convert.ToBoolean(dtMaster.Rows[i]["Approved"]);
                                if (dtMaster.Rows[i]["DeviceIPAddress"] != DBNull.Value) 
                                {
                                    mast.Column1 = dtMaster.Rows[i]["DeviceIPAddress"].ToString();
                                }
                                masters.Add(mast);
                            }
                        }
                    }
                    sqlConnection.Close();
                }

                return masters.FirstOrDefault();
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }
    }
}