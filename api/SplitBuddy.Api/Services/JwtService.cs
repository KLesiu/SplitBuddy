using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace SplitBuddy.Api.Services
{
    public class JwtService
    {
        private readonly IConfiguration _configuration;

        public JwtService(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public (bool IsValid, string Role, string Username, int? UserId) DecodeJwtToken(string authorization)
        {
            if (string.IsNullOrEmpty(authorization) || !authorization.StartsWith("Bearer "))
            {
                return (false, null, null, null);
            }

            var token = authorization.Substring("Bearer ".Length).Trim();

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
                    var userIdClaim = principal.Claims.FirstOrDefault(c => c.Type == "user_id")?.Value;

                    if (int.TryParse(userIdClaim, out int userId))
                    {
                        return (true, role, username, userId);
                    }

                    return (false, null, null, null);
                }

                return (false, null, null, null);
            }
            catch (Exception)
            {
                return (false, null, null, null);
            }
        }
    }
}
