using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;
using XenparkBlankTemplate.Models;

namespace XenparkBlankTemplate
{
    public class SignalServer : Hub{
        public async Task SendMessage(string message)
        {
            await Clients.All.SendAsync("ReceiveMessage", message);
        }
    }
}