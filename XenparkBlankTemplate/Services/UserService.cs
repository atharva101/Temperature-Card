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
using Microsoft.EntityFrameworkCore;
using XenparkBlankTemplate.Helper;

namespace XenparkBlankTemplate.Services
{

    public interface IUserService
    {
        Token Authenticate(LoggedInUser model);

    }
    public class UserService : IUserService
    {
        private readonly AppSetting _appSettings;

        private readonly XPDbContext context;
        public UserService(IOptions<AppSetting> appSettings,
                           XPDbContext db)
        {
            _appSettings = appSettings.Value;
            this.context = db;
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
    }
}
