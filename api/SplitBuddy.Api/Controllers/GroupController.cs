using Microsoft.AspNetCore.Mvc;
using SplitBuddy.Api.Models.Api;
using SplitBuddy.Api.Services;

namespace SplitBuddy.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GroupController : ControllerBase
    {
        private readonly AppDbContext _context;

        public GroupController(AppDbContext context)
        {
            _context = context;

        }

        //[HttpGet("/getGroup")]
        //public async Task<GroupFormVm> Get([FromBody] int id)
        //{
        //    var group = _context.Groups.SingleOrDefault(u => u.Id == id);
           
            

        //}
     
        

    }
}
