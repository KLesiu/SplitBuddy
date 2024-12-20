﻿namespace SplitBuddy.Api.Helpers

{
    using BCrypt.Net;

    public class PasswordHasher
    {
        public string HashPassword(string password)
        {
            return BCrypt.HashPassword(password);
        }

        public bool VerifyPassword(string password, string hashedPassword)
        {
            return BCrypt.Verify(password, hashedPassword);
        }
    }

}
