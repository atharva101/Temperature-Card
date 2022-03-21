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
    public class RoleController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IErrorLogService _errorLogService;
        private readonly XPDbContext context;
        public RoleController(IUserService userService,
                              IErrorLogService errorLogService,
                              XPDbContext db)
        {
            _userService = userService;
            _errorLogService = errorLogService;
            this.context = db;
        }

        [HttpGet]
        public List<Role> GetRoles(bool approveOnly = false)
        {
            List<Role> roles = new List<Role>();
            int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetRoles", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ApproveOnly", approveOnly);
                        DataSet data = new DataSet();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(data);

                        if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                        {
                            DataTable dtset = data.Tables[0];
                            foreach (DataRow dtRow in dtset.Rows)
                            {
                                Role r = new Role();
                                r.Id = dtRow.Field<int>("Id");
                                r.Name = dtRow.Field<string>("Name");
                                r.Description = dtRow.Field<string>("Description");
                                r.SysRole = dtRow.Field<bool>("SysRole");
                                r.Approved = dtRow.Field<bool>("Approved");
                                r.RolePermission = new List<RolePermission>();


                                if (data.Tables.Count > 1 && data.Tables[1].Rows.Count > 0)
                                {
                                    foreach (DataRow drRolePermission in data.Tables[1].Select("RoleId =" + r.Id.ToString()))

                                    {
                                        RolePermission rp = new RolePermission();
                                        rp.Id = drRolePermission.Field<int>("Id");
                                        rp.RoleId = drRolePermission.Field<int>("RoleId");
                                        rp.PermissionId = drRolePermission.Field<int>("PermissionId");
                                        r.RolePermission.Add(rp);
                                    }
                                }

                                roles.Add(r);
                            }

                        }
                    }
                    sqlConnection.Close();
                }

                return roles.Where(x => x.SysRole == false).ToList();
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpGet]
        public List<Permission> GetPermissions()
        {
            List<Permission> permissions = new List<Permission>();
            int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetPermissions", sqlConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        DataSet data = new DataSet();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(data);

                        if (data.Tables.Count > 0 && data.Tables[0].Rows.Count > 0)
                        {
                            DataTable dtset = data.Tables[0];
                            foreach (DataRow dtRow in dtset.Rows)
                            {
                                permissions.Add(new Permission
                                {
                                    Id = dtRow.Field<int>("Id"),
                                    PermissionName = dtRow.Field<string>("PermissionName"),
                                    GroupName = dtRow.Field<string>("GroupName")
                                });
                            }

                        }
                    }
                    sqlConnection.Close();
                }

                return permissions;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpPost]
        public int MaintainRole(Role roles)
        {
            int returnValue = -101;
            try
            {
                string permissionIds = "";
                if (roles.RolePermission != null && roles.RolePermission.Count > 0)
                {
                    permissionIds = String.Join(',', roles.RolePermission.Select(x => x.PermissionId).ToList());
                }
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sprocAddEditRolePermission", sqlConnection))
                    {

                        sqlConnection.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@RoleId", roles.Id);
                        cmd.Parameters.AddWithValue("@RoleName", roles.Name);
                        cmd.Parameters.AddWithValue("@RoleDescription", roles.Description);
                        cmd.Parameters.AddWithValue("@PermissionIds", permissionIds);

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
        public List<Permission> GetUserPermissions()
        {
            List<Permission> permissions = new List<Permission>();
            int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString))
                {
                    sqlConnection.Open();
                    using (SqlCommand cmd = new SqlCommand("sprocGetUserPermissions", sqlConnection))
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
                                permissions.Add(new Permission
                                {
                                    Id = dtRow.Field<int>("Id"),
                                    PermissionName = dtRow.Field<string>("PermissionName"),
                                });
                            }

                        }
                    }
                    sqlConnection.Close();
                }

                return permissions;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

    }
}
