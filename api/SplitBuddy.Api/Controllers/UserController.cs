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
                return Unauthorized(Responses.UNAUTHORIZED);
            }

            // Generowanie tokenu JWT
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
        public IActionResult DecodeToken([FromHeader] string Authorization)
        {
            if (string.IsNullOrEmpty(Authorization) || !Authorization.StartsWith("Bearer "))
            {
                return Unauthorized(Responses.UNAUTHORIZED); 
            }

            var token = Authorization.Substring("Bearer ".Length).Trim();

            var result = DecodeJwtToken(token);

            if (!result.IsValid)
            {
                return Unauthorized(Responses.UNAUTHORIZED);  
            }

            if (int.TryParse(result.UserId, out int userId))
            {
                return Ok(new { result.Id, result.Role, result.Username, userId });
            }
            else
            {
                return Unauthorized(Responses.UNAUTHORIZED);

            }

        }



        private string GenerateJwtToken(User user)
        {
            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, user.Username),
                new Claim(ClaimTypes.Role, user.Role),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim("user_id",user.Id.ToString())
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

        private (bool IsValid, string Id, string Role, string Username,string UserId) DecodeJwtToken(string token)
        {
            var jwtConfig = _configuration.GetSection("JwtConfig");
            var validationParameters = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidateLifetime = true,
                ValidateIssuerSigningKey = true,
                ValidIssuer = jwtConfig["Issuer"],
                ValidAudience = jwtConfig["Audience"],
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtConfig["Key"]))
            };

            try
            {
                var tokenHandler = new JwtSecurityTokenHandler();
                var principal = tokenHandler.ValidateToken(token, validationParameters, out SecurityToken validatedToken);

                if (validatedToken is JwtSecurityToken jwtToken)
                {
                    var username = principal.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                    var role = principal.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                    var id = principal.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Jti)?.Value;
                    var userId = principal.Claims.FirstOrDefault(c => c.Type == "user_id")?.Value;

                    return (true, id, role, username, userId);
                }

                return (false, null, null, null, null);
            }
            catch (Exception)
            {
                return (false, null, null, null,null);
            }
        }
    }
}