using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace XenparkBlankTemplate.Helper
{
    enum ResponseCode
    {
        Success = -101,
        ValidationSuccess = -102,
        SendEmail = -103,
        ErrorOccured = -501,
        AlreadyExists = -502,
        DBConnectionFailed = -1001,
        CompanyDoesnotExists = -1,
        CompanyDisabled = -2,
        CompanyUnVerified = -3,
        UserDoesnotExists = -4,
        UserDisabled = -5,
        AdminDoesNotExists = -6,
        IncorrectOTP = -7,
        UserNamePasswordIncorrect = -8,
        EmailAlreadyExists = -9,
        UserNameAlreadyExists = -10
    }
    public static class Constants
    {
       
    }
}
