using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using SplitBuddy.Api.Enums;
using SplitBuddy.Api.Helpers;
using SplitBuddy.Api.Models.Api;
using SplitBuddy.Api.Models.Entities;
using SplitBuddy.Api.Services;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace SplitBuddy.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController(AppDbContext context, PasswordHasher passwordHasher, IConfiguration configuration) : ControllerBase
    {
        private readonly PasswordHasher _passwordHasher = passwordHasher;
        private readonly AppDbContext _context = context;
        private readonly IConfiguration _configuration = configuration;

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginFormVm request)
        {
            var user = _context.Users.SingleOrDefault(u => u.Username == request.Username);
            if (user == null || !_passwordHasher.VerifyPassword(request.Password, user.PasswordHash))
            {
                return Unauthorized("Invalid credentials");
            }

            // Generowanie tokenu JWT
            var token = GenerateJwtToken(user);
            return Ok(new { Token = token });
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterFormVm request)
        {
            if (_context.Users.Any(u => u.Username == request.Username))
            {
                return BadRequest("User already exists.");
            }

            var passwordHash = _passwordHasher.HashPassword(request.Password);

            var user = new User
            {
                Username = request.Username,
                PasswordHash = passwordHash,
                Role = Roles.User.ToString(),
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            return Ok(Responses.SUCCESS);
        }

        private string GenerateJwtToken(User user)
        {
            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Username),
                new Claim(ClaimTypes.Role, user.Role),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var jwtConfig = _configuration.GetSection("JwtConfig");
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtConfig["Key"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: jwtConfig["Issuer"],
                audience: jwtConfig["Audience"],
                claims: claims,
                expires: DateTime.Now.AddMinutes(double.Parse(jwtConfig["TokenValidityMins"])),
                signingCredentials: creds);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}


