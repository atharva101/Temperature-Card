using System;
using MailKit.Net.Smtp;
using MimeKit;
using XenparkBlankTemplate.Models;
using Microsoft.Extensions.Options;

namespace XenparkBlankTemplate.Services
{
    public interface IEmailService
    {
        bool SendEmail(Email email);

    }
    public class EmailService : IEmailService
    {
        private readonly AppSetting _appSettings;
        public EmailService(IOptions<AppSetting> appSettings)
        {
            _appSettings = appSettings.Value;
        }
        public bool SendEmail(Email email)
        {
            try
            {
                MimeMessage message = new MimeMessage();
                MailboxAddress from = new MailboxAddress("Admin", _appSettings.EmailFrom);
                message.From.Add(from);

                MailboxAddress to = new MailboxAddress("User", email.To);
                message.To.Add(to);

                message.Subject = email.Subject;

                BodyBuilder body = new BodyBuilder();
                body.HtmlBody = email.Body;

                message.Body = body.ToMessageBody();

                SmtpClient client = new SmtpClient();
                client.Connect(_appSettings.EmailHostServer, int.Parse(_appSettings.EmailPort), true);
                client.Authenticate(_appSettings.EmailUser, _appSettings.EmailPassword);

                client.Send(message);
                client.Disconnect(true);
                client.Dispose();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
