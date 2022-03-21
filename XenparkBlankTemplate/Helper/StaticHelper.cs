using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MailKit.Net.Smtp;
using MimeKit;
using XenparkBlankTemplate.Models;
using System.IO;
using System.Text;
using System.Security.Cryptography;
using Microsoft.AspNetCore.Mvc;
using System.Xml.Serialization;
using System.Xml;

namespace XenparkBlankTemplate.Helper
{
    public static class StaticHelper
    {
        public static string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }

        public static string Decrypt(string cipherText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }
        public static string GenerateRandomOTP(int iOTPLength)
        {
            string[] saAllowedCharacters = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" };
            string sOTP = String.Empty;
            string sTempChars = String.Empty;
            Random rand = new Random();
            for (int i = 0; i < iOTPLength; i++)
            {
                int p = rand.Next(0, saAllowedCharacters.Length);
                sTempChars = saAllowedCharacters[rand.Next(0, saAllowedCharacters.Length)];
                sOTP += sTempChars;
            }
            return sOTP;

        }
        public static bool SendMail(Email email)
        {
            try
            {
                MimeMessage message = new MimeMessage();
                MailboxAddress from = new MailboxAddress("Admin", "mockupportal@gmail.com");
                message.From.Add(from);

                MailboxAddress to = new MailboxAddress("User", email.To);
                message.To.Add(to);

                message.Subject = email.Subject;

                BodyBuilder body = new BodyBuilder();
                body.HtmlBody = email.Body;

                message.Body = body.ToMessageBody();

                SmtpClient client = new SmtpClient();
                client.Connect("smtp.gmail.com", 465, true);
                client.Authenticate("mockupportal@gmail.com", "Mockup@2020");

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

        public static string ToXml<T>(this List<T> list)
        {
            XmlSerializer xmlSerializer = new XmlSerializer(typeof(List<T>));

            StringWriter stringWriter = new StringWriter();
            XmlTextWriter xmlWriter = new XmlTextWriter(stringWriter);

            xmlWriter.Formatting = Formatting.Indented;
            xmlSerializer.Serialize(xmlWriter, list);

            return stringWriter.ToString();
        }
    }
}
