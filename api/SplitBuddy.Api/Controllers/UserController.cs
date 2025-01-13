using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SplitBuddy.Api.Enums;
using SplitBuddy.Api.Helpers;
using SplitBuddy.Api.Models.Api;
using SplitBuddy.Api.Models.Entities;
using SplitBuddy.Api.Services;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Text;

namespace SplitBuddy.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController(AppDbContext context, PasswordHasher passwordHasher, IConfiguration configuration, JwtService jwtService, IMapper mapper) : ControllerBase
    {
        private readonly PasswordHasher _passwordHasher = passwordHasher;
        private readonly AppDbContext _context = context;
        private readonly IConfiguration _configuration = configuration;
        private readonly JwtService _jwtService = jwtService;
        private readonly IMapper _mapper = mapper;


        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginFormVm request)
        {
            var user = _context.Users.SingleOrDefault(u => u.Username == request.Username);
            if (user == null || !_passwordHasher.VerifyPassword(request.Password, user.PasswordHash))
            {
                return Unauthorized(Responses.UNAUTHORIZED);
            }

            var token = GenerateJwtToken(user);
            return Ok(new { Token = token });
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterFormVm request)
        {
            var existingUser = _context.Users
                .Where(u => u.Username == request.Username || u.Email == request.Email)
                .Select(u => new { u.Username, u.Email })
                .FirstOrDefault();

            if (existingUser != null)
            {
                if (existingUser.Username == request.Username)
                    return BadRequest(Responses.USEREXIST);

                if (existingUser.Email == request.Email)
                    return BadRequest(Responses.EMAILEXIST);
            }

            var passwordHash = _passwordHasher.HashPassword(request.Password);

            var user = new User
            {
                Username = request.Username,
                PasswordHash = passwordHash,
                Role = Roles.User.ToString(),
                Email = request.Email,
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            return Ok(Responses.SUCCESS);
        }
        [HttpGet("checkToken")]
        public IActionResult CheckToken([FromHeader] string Authorization)
        {

            var result = _jwtService.DecodeJwtToken(Authorization);

            if (!result.IsValid)
            {
                return Unauthorized(Responses.UNAUTHORIZED);
            }
            return Ok(new { result.Role, result.Username, result.UserId });

        }


        [HttpGet("getUser")]
        public async Task<UserFormVm?> GetUser([FromHeader] string Authorization)
        {
            var tokenInfo = _jwtService.DecodeJwtToken(Authorization);
            var userId = tokenInfo.UserId;
            var user = await _context.Users.SingleOrDefaultAsync(u => u.Id == userId);
            if (user is null) return null;
            return _mapper.Map<UserFormVm>(user);
        }



        private string GenerateJwtToken(User user)
        {
            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, user.Username),
                new Claim(ClaimTypes.Role, user.Role),
                new Claim("user_id",user.Id.ToString())
            };

            var jwtConfig = _configuration.GetSection("JwtConfig");
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtConfig["Key"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: jwtConfig["Issuer"],
                audience: jwtConfig["Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(double.Parse(jwtConfig["TokenValidityMins"])),
                signingCredentials: creds);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

    }
}