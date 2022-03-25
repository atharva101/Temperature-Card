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
    public class MasterController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IErrorLogService _errorLogService;
        private readonly XPDbContext context;

        public MasterController(IUserService userService,
                              IErrorLogService errorLogService,
                              XPDbContext db)
        {
            _userService = userService;
            _errorLogService = errorLogService;
            this.context = db;
        }

        [HttpGet]
        public List<Master> GetMasters(string type, int parentId = 0, bool approveOnly = false)
        {

            List<Master> masters = new List<Master>();
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetMaster", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        DataSet data = new DataSet();
                        cmd.Parameters.AddWithValue("@Type", type);
                        cmd.Parameters.AddWithValue("@ParentId", parentId);
                        cmd.Parameters.AddWithValue("@ApproveOnly", approveOnly);
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
                                mast.Column1 = dtMaster.Rows[i]["Column1"].ToString();
                                mast.Column2 = dtMaster.Rows[i]["Column2"].ToString();
                                mast.Column3 = dtMaster.Rows[i]["Column3"].ToString();
                                mast.ParentId = Convert.ToInt32(dtMaster.Rows[i]["ParentId"]);
                                mast.ParentCode = dtMaster.Rows[i]["ParentCode"].ToString();
                                mast.ParentDescription = dtMaster.Rows[i]["ParentDescription"].ToString();
                                mast.Approved = Convert.ToBoolean(dtMaster.Rows[i]["Approved"]);
                                mast.IsUsed = Convert.ToBoolean(dtMaster.Rows[i]["IsUsed"]);
                                
                                masters.Add(mast);
                            }
                        }
                    }
                    sqlConnection.Close();
                }

                return masters;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpGet]
        public List<Master> GetParentData(string type, bool approveOnly = false)
        {

            List<Master> masters = new List<Master>();
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetMaster", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        DataSet data = new DataSet();
                        cmd.Parameters.AddWithValue("@Type", type);
                        cmd.Parameters.AddWithValue("@ParentId", 0);
                        cmd.Parameters.AddWithValue("@ApproveOnly", approveOnly);
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
                                masters.Add(mast);
                            }
                        }
                    }
                    sqlConnection.Close();
                }

                return masters;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpPost]
        public int AddEditMaster(string type, Master mast)
        {
            int returnValue = -101;
            try
            {
                
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sprocAddEditMaster", sqlConnection))
                    {
                        sqlConnection.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Id", mast.Id);
                        cmd.Parameters.AddWithValue("@Code", mast.Code ?? "");
                        cmd.Parameters.AddWithValue("@Description", mast.Description);
                        cmd.Parameters.AddWithValue("@Column1", mast.Column1??"");
                        cmd.Parameters.AddWithValue("@Column2", mast.Column2 ?? "");
                        cmd.Parameters.AddWithValue("@Column3", mast.Column3 ?? "");
                        cmd.Parameters.AddWithValue("@ParentId", mast.ParentId);
                        cmd.Parameters.AddWithValue("@Type", type);
                        

                        cmd.Parameters.Add("@ReturnValue", SqlDbType.Int);
                        cmd.Parameters["@ReturnValue"].Direction = ParameterDirection.Output;

                        cmd.ExecuteNonQuery();
                        returnValue = Convert.ToInt32(cmd.Parameters["@ReturnValue"].Value);
                        sqlConnection.Close();
                    }
                    // If type = room and there is an IP associated then add user for the device. 
                    if (type == "room" && mast.Column1 != null && mast.Column1 != "" ) 
                    {
                        User user = new User() 
                        {
                            FirstName = "Device", 
                            LastName = mast.Column1,
                            UserName = mast.Column1,
                            RoleId = -1, // For Device 
                            Email= "donotreply@mylan.com"

                        };
                        string temppassword = EncryptDecryptHelper.EncryptStringAES(user.UserName);
                        var result = _userService.MaintainUser(user, temppassword);
                        if (result == (int)ResponseCode.ErrorOccured) 
                        {
                            throw new Exception("Register device failed");
                        }
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
        public List<RoomMaster> GetRoomMaster()
        {

            List<RoomMaster> masters = new List<RoomMaster>();
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetRoomMaster", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        DataSet data = new DataSet();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(data);

                        if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                        {
                            DataTable dtMaster = data.Tables[0];
                            for (int i = 0; i < dtMaster.Rows.Count; i++)
                            {
                                RoomMaster mast = new RoomMaster();
                                mast.RoomId = Convert.ToInt32(dtMaster.Rows[i]["RoomId"]);
                                mast.RoomCode = dtMaster.Rows[i]["RoomCode"].ToString();
                                mast.RoomDescription = dtMaster.Rows[i]["RoomDescription"].ToString();

                                mast.AreaId = Convert.ToInt32(dtMaster.Rows[i]["AreaId"]);
                                mast.AreaCode = dtMaster.Rows[i]["AreaCode"].ToString();
                                mast.AreaDescription = dtMaster.Rows[i]["AreaDescription"].ToString();

                                mast.BlockId = Convert.ToInt32(dtMaster.Rows[i]["BlockId"]);
                                mast.BlockCode = dtMaster.Rows[i]["BlockCode"].ToString();
                                mast.BlockDescription = dtMaster.Rows[i]["BlockDescription"].ToString();

                                mast.PlantId = Convert.ToInt32(dtMaster.Rows[i]["PlantId"]);
                                mast.PlantName = dtMaster.Rows[i]["PlantName"].ToString();
                                mast.PlantLocation = dtMaster.Rows[i]["PlantLocation"].ToString();
                                masters.Add(mast);
                            }
                        }
                    }
                    sqlConnection.Close();
                }

                return masters;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpGet]
        public bool DeleteMaster(string type, int id)
        {
            bool allowed = true;
            try
            {
                
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sprocDeleteMaster", sqlConnection))
                    {
                        sqlConnection.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.Parameters.AddWithValue("@Type", type);
                        cmd.Parameters.Add("@Allowed", SqlDbType.Bit);
                        cmd.Parameters["@Allowed"].Direction = ParameterDirection.Output;

                        cmd.ExecuteNonQuery();
                        allowed = Convert.ToBoolean(cmd.Parameters["@Allowed"].Value == DBNull.Value ?  false : cmd.Parameters["@Allowed"].Value);
                        if (!allowed) 
                        {
                            throw new Exception("Not Allowed");
                        }
                        sqlConnection.Close();
                    }

                }
                return allowed;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return false;
            }
        }

        [HttpGet]
        public List<Menu> GetMenus()
        {
            List<Menu> menus = new List<Menu>();
            int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetMenus", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserId", userID);
                        DataSet data = new DataSet();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(data);

                        if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                        {
                            DataTable dtset = data.Tables[0];
                            foreach (DataRow dtRow in dtset.Rows)
                            {
                                menus.Add(new Menu
                                {
                                    Id = dtRow.Field<int>("Id"),
                                    Title = dtRow.Field<string>("Title"),
                                    Type = dtRow.Field<string>("Type"),
                                    URL = dtRow.Field<string>("URL"),
                                    Icon = dtRow.Field<string>("Icon"),
                                    Target = dtRow.Field<bool?>("Target"),
                                    Breadcrumbs = dtRow.Field<bool?>("Breadcrumbs"),
                                    Classes = dtRow.Field<string>("Classes"),
                                    ParentId = dtRow.Field<int?>("ParentId"),
                                    Children = new List<Menu>()
                                });
                            }

                        }
                    }
                    sqlConnection.Close();
                }

                var m = GetNestedChildren(menus, 0);
                return m;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        public List<Menu> GetNestedChildren(List<Menu> arr, int parent)
        {
            List<Menu> res = new List<Menu>();
            foreach (var i in arr)
            {
                if (i.ParentId == parent)
                {
                    var children = GetNestedChildren(arr, i.Id);

                    if (children.Count > 0)
                    {
                        i.Children = children;
                    }
                    res.Add(i);
                }
            }
            return res;
        }

        [HttpGet]
        public int ApproveMaster(string type, int Id)
        {
            int returnVal = 0;
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocApproveMaster", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        DataSet data = new DataSet();
                        cmd.Parameters.AddWithValue("@Type", type);
                        cmd.Parameters.AddWithValue("@Id", Id);
                        cmd.ExecuteNonQuery();
                        returnVal = 501;
                    }
                    sqlConnection.Close();
                }
                return returnVal;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return -501; ;
            }
        }

    }
}
