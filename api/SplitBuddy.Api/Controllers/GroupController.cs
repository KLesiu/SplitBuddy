using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SplitBuddy.Api.Models.Api;
using SplitBuddy.Api.Models.Entities;
using SplitBuddy.Api.Services;

namespace SplitBuddy.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GroupController(AppDbContext context, IMapper mapper) : ControllerBase
    {
        private readonly AppDbContext _context = context;
        private readonly IMapper _mapper = mapper;

        [HttpGet("/getGroup/{groupId}")]
        public async Task<GroupFormVm> Get(int groupId)
        {
            var group = await  _context.Groups.Include(g => g.Owner).SingleOrDefaultAsync(u => u.Id == groupId);
            return  _mapper.Map<GroupFormVm>(group);
        }

        [HttpPost("/createGroup")]
        public async Task<int?> Create([FromBody] GroupFormVm form)

        {
            var user =  await _context.Users.SingleOrDefaultAsync(u=>u.Id == form.Owner.Id);
            if (user is null) return null;
            var newGroup = new Group
            {
                Name = form.Name,
                Owner = user,
                CreatedDate = DateTime.UtcNow,

            };

            _context.Groups.Add(newGroup);
            await _context.SaveChangesAsync();
            return newGroup.Id;

        }

        [HttpPost("/updateGroup")]
        public async Task<int?> Update([FromBody] GroupFormVm form)
        {
            var group = await _context.Groups.SingleOrDefaultAsync(u=>u.Id == form.Id);
            if (group is null) return null;
            group.Name = form.Name;
            await _context.SaveChangesAsync();
            return group.Id;
        }



    }
}
