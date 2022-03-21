using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Options;
using XenparkBlankTemplate.Entity;
using XenparkBlankTemplate.Models;

namespace XenparkBlankTemplate.Services
{
    public interface IErrorLogService
    {
        void LogError(Exception model);

    }
    public class ErrorLogService : IErrorLogService
    {
        private readonly AppSetting _appSettings;

        private readonly XPDbContext context;
        public ErrorLogService(IOptions<AppSetting> appSettings,
                           XPDbContext db)
        {
            _appSettings = appSettings.Value;
            this.context = db;
        }
        public void LogError(Exception ex)
        {
            try
            {
                var errorObj = new ErrorLog();
                errorObj.Date = DateTime.Now;
                errorObj.Message = ex.Message;
                errorObj.StackTrace = ex.StackTrace;
                errorObj.Source = ex.Source;
                errorObj.TargetSite = ex.TargetSite.ToString();
                context.ErrorLog.Add(errorObj);
                context.SaveChanges();
            }
            catch (Exception exp)
            {
                throw new Exception("Exception from Error Logging");
            }


        }
    }
}
