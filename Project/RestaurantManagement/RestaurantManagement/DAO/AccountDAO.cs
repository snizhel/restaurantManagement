using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantManagement.DAO
{
    public class AccountDAO
    {
        private static AccountDAO instance;

        public static AccountDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new AccountDAO();
                }
                return AccountDAO.instance;
            }
            private set
            {
                instance = value;
            }
        }

        private AccountDAO()
        { }

        public bool Signin(string userName, string passWord)
        {
            //string passEncode = MD5Hash(Base64Encode(passWord));
            string query = "exec usp_Login @userName ,@passWord ";

            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] {userName, passWord });

            return result.Rows.Count > 0;
        }
        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public static string MD5Hash(string input)
        {
            StringBuilder hash = new StringBuilder();
            MD5CryptoServiceProvider md5provider = new MD5CryptoServiceProvider();
            byte[] bytes = md5provider.ComputeHash(new UTF8Encoding().GetBytes(input));

            for (int i = 0; i < bytes.Length; i++)
            {
                hash.Append(bytes[i].ToString("x2"));
            }
            return hash.ToString();
        }
    }
}
