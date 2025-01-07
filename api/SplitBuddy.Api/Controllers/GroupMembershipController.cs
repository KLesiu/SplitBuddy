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
    public class GroupMembershipController(AppDbContext context, IMapper mapper)
    {
        private readonly AppDbContext _context = context;
        private readonly IMapper _mapper = mapper;

        [HttpGet("getGroupMembership/{groupMembershipId}")]
        public async Task<GroupMembershipFormVm> Get(int groupMembershipId)
        {
            var groupMembership = await _context.GroupMembership.Include(g => g.User).Include(g => g.Group).SingleOrDefaultAsync(u=>u.Id == groupMembershipId);
            return _mapper.Map<GroupMembershipFormVm>(groupMembership);
        }

        [HttpPost("joinNewMember")]
        public async Task<bool> JoinNewMember([FromBody] MemberFormVm form)
        {
            var user = await _context.Users.SingleOrDefaultAsync(u => u.Id == form.UserId);
            if (user is null) return false;
            var group = await _context.Groups.SingleOrDefaultAsync(u => u.Id == form.GroupId);
            if (group is null) return false;

            var groupMemberShipEntityForm = new GroupMembership { Group= group, User=user};
            var result = await Create(groupMemberShipEntityForm);
            if(result is null) return false;
            return true; 

        }

        [HttpDelete("deleteMember")]
        public async Task<bool> DeleteMember([FromBody] MemberFormVm form)
        {
            var groupMemberShip = await _context.GroupMembership.Where(s=>s.Group.Id == form.GroupId && s.User.Id == form.UserId).SingleOrDefaultAsync();
            if (groupMemberShip is null)return false;
            _context.GroupMembership.Remove(groupMemberShip);
            await _context.SaveChangesAsync();
            return true;

        }

        private async Task<int?> Create([FromBody] GroupMembership form)
        {
            _context.GroupMembership.Add(form);
            await _context.SaveChangesAsync();
            return form.Id;

        }
    }
}
