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
using System.Data;
using System.Security.Claims;


// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace XenparkBlankTemplate.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [Authorize]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IErrorLogService _errorLogService;
        private readonly XPDbContext context;
        private readonly IEmailService _emailService;

        public UserController(IUserService userService,
                              IErrorLogService errorLogService,
                              XPDbContext db,
                              IEmailService emailService)
        {
            _userService = userService;
            _errorLogService = errorLogService;
            this.context = db;
            _emailService = emailService;
        }



        [AllowAnonymous]
        [HttpPost]
        public Token Authenticate([FromBody] LoggedInUser model)
        {
            try
            {
                // if (DateTime.Now >= new DateTime(2022, 4, 30))
                // {
                //     return new Token() { ResponseCode = (int)ResponseCode.CompanyDisabled };
                // }
                //Check the device for login
                model.Password = model.Password != null && model.Password.Length > 0 ? EncryptDecryptHelper.DecryptStringAES(model.Password) : "";
                if (model.UserName == "ip" && model.Password == "ip") 
                {
                    model.UserName  = _userService.GetClientIP(Request.HttpContext.Connection.RemoteIpAddress);
                    model.Password = _userService.GetClientIP(Request.HttpContext.Connection.RemoteIpAddress);   
                }
    
                return _userService.Authenticate(model);
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return new Token() { ResponseCode = (int)ResponseCode.ErrorOccured };
            }
        }

        [HttpGet]
        public User Me()
        {
            try
            {
                int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);
                var user = context.User.Where(x => x.Id == userID && x.IsDeleted == false).FirstOrDefault();
                return user;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex); 
                return null;
            }
        }

        [HttpPost]
        public int Logout()
        {
            var user = User as ClaimsPrincipal;
            var identity = user.Identity as ClaimsIdentity;
            var claim = (from c in user.Claims
                         where c.Type == System.Security.Claims.ClaimTypes.Name
                         select c).Single();
            identity.RemoveClaim(claim);
            return 101;
        }

        [HttpGet]
        public List<User> GetUsers()
        {
            try
            {
                var users = context.User
                    .Include(x => x.UserRooms).Where(x => x.IsDeleted == false).ToList();
                return users;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return null;
            }
        }

        [HttpPost]
        public int AddEditUser(User user)
        {
            string temppassword = StaticHelper.Encrypt(user.UserName);//StaticHelper.Encrypt(StaticHelper.GenerateRandomOTP(6));
            return _userService.MaintainUser(user, temppassword);
        }

        
        public bool IsFirstLogin()
        {
            try
            {
                int userID = Convert.ToInt32(User.Claims.Where(x => x.Type == System.Security.Claims.ClaimTypes.Name).FirstOrDefault().Value);
                var user = context.LoginInfo.Where(x => x.UserId == userID && x.ForceChangePassword == true).FirstOrDefault();
                return user != null;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return false;
            }

        }

        [HttpPost]
        public int UpdateLoginInfo(LoginInfo loginInfo)
        {
            try
            {
                var user = context.LoginInfo.Where(x => x.UserId == loginInfo.UserId).FirstOrDefault();
                if (user == null) return -201;
                if (loginInfo.Password != null && loginInfo.Password.Length > 0)
                {
                    user.Password = StaticHelper.Encrypt(loginInfo.Password);
                    user.ForceChangePassword = false;
                    context.LoginInfo.Attach(user);
                    context.Entry(user).Property(x => x.Password).IsModified = true;
                }
                else
                {
                    user.LastLogInTime = DateTime.Now;
                    context.LoginInfo.Attach(user);
                    context.Entry(user).Property(x => x.LastLogInTime).IsModified = true;
                }
                context.SaveChanges();
                return 101;
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return (int)ResponseCode.ErrorOccured;
            }
        }



        [AllowAnonymous]
        [HttpPost]
        public int SendEmail(Email emailInfo)
        {
            Email email = new Email();
            try
            {

                if (emailInfo.Case == "UserTemperoryPassword")
                {
                    var user = context.User.Where(x => x.Email == emailInfo.User.Email && x.UserName == emailInfo.User.UserName).FirstOrDefault();
                    var loginInfo = context.LoginInfo.Where(x => x.UserId == user.Id).FirstOrDefault();
                    email = new Email()
                    {
                        To = user.Email,
                        Subject = "Welcome to XenparkBlankTemplate",
                        Body = "<h3>Hello " + user.Email + "</h3><p>Welcome to XenparkBlankTemplate. Here is your login details.</p><p>User Name = " + user.UserName + " <br/>Password = " + StaticHelper.Decrypt(loginInfo.Password) + "</p><p>Thank you <br/>XenparkBlankTemplate Team</p>"
                    };
                }
                else if (emailInfo.Case == "ForgotPassword")
                {
                    var user = context.User.Where(x => x.Email == emailInfo.User.Email).FirstOrDefault();
                    var loginInfo = context.LoginInfo.Where(x => x.UserId == user.Id).FirstOrDefault();
                    email = new Email()
                    {
                        To = user.Email,
                        Subject = "XenparkBlankTemplate - Forgot Password",
                        Body = "<h3>Hello " + user.FirstName + " " + user.LastName + "</h3><p>Your temperory Password for login is " + StaticHelper.Decrypt(loginInfo.Password) + ".</p><p>Thank you <br/>XenparkBlankTemplate Team</p>"
                    };
                }
                if (_emailService.SendEmail(email))
                {
                    return (int)ResponseCode.Success;
                }
            }
            catch (Exception ex)
            {
                _errorLogService.LogError(ex);
                return (int)ResponseCode.ErrorOccured;
            }
            return (int)ResponseCode.ErrorOccured;
        }
    }
}
