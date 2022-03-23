using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using XenparkBlankTemplate.Models;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.Extensions.Options;
using System.Text;
using XenparkBlankTemplate.Entity;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.EntityFrameworkCore;
using XenparkBlankTemplate.Helper;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Net;
using System.Net.Sockets;

namespace XenparkBlankTemplate.Services
{

    public interface IUserService
    {
        Token Authenticate(LoggedInUser model);
        int MaintainUser(User user, string password);
        string GetClientIP(IPAddress ip);

    }
    public class UserService : IUserService
    {
        private readonly AppSetting _appSettings;

        private readonly XPDbContext context;

        private readonly IErrorLogService _errorLogService;
        public UserService(IOptions<AppSetting> appSettings,
                           XPDbContext db,
                           IErrorLogService errorLogService)
        {
            _appSettings = appSettings.Value;
            this.context = db;
            _errorLogService = errorLogService;
        }
        public Token Authenticate(LoggedInUser model)
        {
            
            var user = context.User
                .Where(x => (x.UserName == model.UserName || x.Email == model.UserName) ).FirstOrDefault();
            if (user == null) return new Token() { ResponseCode = (int)ResponseCode.UserDoesnotExists };
            if (user.IsDisabled == true) return new Token() { ResponseCode = (int)ResponseCode.UserDisabled };


            var loginInfo = context.LoginInfo
                .Where(x => x.UserId == user.Id && x.Password == StaticHelper.Encrypt(model.Password))
                .FirstOrDefault();

            if (loginInfo == null) return new Token() { ResponseCode = (int)ResponseCode.UserNamePasswordIncorrect };

            // authentication successful so generate jwt token
            var token = generateJwtToken(user);

            return new Token()
            {                
                access_token = token,
                ResponseCode = (int)ResponseCode.Success
            };
        }

        private string generateJwtToken(User user)
        {
            // generate token that is valid for 7 days
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Id.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);            
            return tokenHandler.WriteToken(token);
        }

        public int MaintainUser(User user, string password)
        {
            password = StaticHelper.Encrypt(user.UserName);
            try
            {
                using SqlConnection sqlConnection = new SqlConnection(context.Database.GetDbConnection().ConnectionString);

                using SqlCommand cmd = new SqlCommand("sprocAddEditUser", sqlConnection);

                sqlConnection.Open();
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserId", user.Id);
                cmd.Parameters.AddWithValue("@FirstName", user.FirstName);
                cmd.Parameters.AddWithValue("@LastName", user.LastName);
                cmd.Parameters.AddWithValue("@Email", user.Email);
                cmd.Parameters.AddWithValue("@UserName", user.UserName);
                cmd.Parameters.AddWithValue("@IsDisabled", user.IsDisabled ?? false);
                cmd.Parameters.AddWithValue("@IsDeleted", user.IsDeleted ?? false);
                if (user.RoleId == null)
                    cmd.Parameters.AddWithValue("@RoleId", DBNull.Value);
                else
                    cmd.Parameters.AddWithValue("@RoleId", user.RoleId ?? 0);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.Add("@ReturnValue", SqlDbType.Int);
                cmd.Parameters["@ReturnValue"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                int returnValue = Convert.ToInt32(cmd.Parameters["@ReturnValue"].Value);
                sqlConnection.Close();
                return returnValue;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return (int)ResponseCode.ErrorOccured;
            }
        }

        public string GetClientIP(IPAddress ip)
        {
            string ipAddress = string.Empty;
            //IPAddress ip = Request.HttpContext.Connection.RemoteIpAddress;
            if (ip != null)
            {
                if (ip.AddressFamily == AddressFamily.InterNetworkV6)
                {
                    ip = Dns.GetHostEntry(ip).AddressList
                    .First(x => x.AddressFamily == AddressFamily.InterNetwork);
                }
                ipAddress = ip.ToString();
            }
            return ipAddress;
        }
    }
}
