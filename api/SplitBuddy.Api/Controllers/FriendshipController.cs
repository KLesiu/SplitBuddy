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
    public class FriendshipController(AppDbContext context, IMapper mapper, JwtService jwtService): ControllerBase
    {
        private readonly AppDbContext _context = context;
        private readonly IMapper _mapper = mapper;
        private readonly JwtService _jwtService = jwtService;



        [HttpPost("addFriend")]
        public async Task<int?> AddFriend([FromHeader] string Authorization,[FromBody] FriendFormVm form)
        {
            var tokenInfo = _jwtService.DecodeJwtToken(Authorization);
            var userId = tokenInfo.UserId;
            var user = await _context.Users.SingleOrDefaultAsync(u => u.Id == userId);
            if (user is null) return null;
            var friend = await _context.Users.SingleOrDefaultAsync(u => u.Email == form.Email);
            if (friend is null) return null;

            var friendship = new Friendship { Friend=friend, User=user };
            _context.Friendships.Add(friendship);
            await _context.SaveChangesAsync();
            return friendship.Id;

        }

        [HttpGet("getFriends")]
        public async Task<List<UserFormVm>?> GetFriends([FromHeader] string Authorization)
        {
            var tokenInfo = _jwtService.DecodeJwtToken(Authorization);
            var userId = tokenInfo.UserId;
            var user = await _context.Users.SingleOrDefaultAsync(u => u.Id == userId);
            if (user is null) return null;
            var friends = await _context.Friendships
               .Where(f => f.User.Id == userId || f.Friend.Id == userId)
               .Select(f => f.User.Id == userId ? f.Friend : f.User)
               .ToListAsync();

            var friendVms = _mapper.Map<List<UserFormVm>>(friends);

            return friendVms;
        }


    }
}
