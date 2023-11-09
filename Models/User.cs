using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Cryptography;
namespace PE2023test.Models
{
    public class User
    {
        public int ISSN { get; set; }
        [Required]
        public string Name { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Pass { get; set; } = null;
        public int ACCESS_CONTROL { get; set; }
        
        //hash password func
        public static byte[] GetHash(string inputString)
        {
            using (HashAlgorithm algorithm = SHA256.Create())
                return algorithm.ComputeHash(Encoding.UTF8.GetBytes(inputString));
        }

        public static string GetHashString(string inputString)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in GetHash(inputString))
                sb.Append(b.ToString("X2"));

            return sb.ToString();
        }

        public void hashPass()
        {
            this.Pass = GetHashString(this.Pass);
        }
        public bool checkPassword(string pass)
        {
            bool res = false;
            if (!string.IsNullOrEmpty(pass))
            {
                if(this.Pass == GetHashString(pass)) { res = true;}
            }
            return res;
        }
    }
}
