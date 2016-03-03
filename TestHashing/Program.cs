using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace TestHashing
{
    class Program
    {
        struct Acc
        {
            public string Password;
            public string UserName;
        }
        static void Main(string[] args)
        {
            Acc model = new Acc();
            model.Password = "123";
            model.UserName = "asdfsdfsdf";
            var pass = model.Password;
            var name = model.UserName;
            string preHash = "";

            // Salt
            for(int i = 0; i < pass.Length; i++)
            {
                int c0 = pass[i];
                int c1 = name[i % name.Length];
                preHash += (char)(c0 ^ c1);
            }

            for (int i = 0; i < name.Length; i++)
            {
                int c0 = pass[i % pass.Length];
                int c1 = name[i];
                preHash += (char)(c0 ^ c1);
            }

            preHash += model.Password;
            SHA256 hashFunction = SHA256Managed.Create();
            var hash = hashFunction.ComputeHash(Encoding.UTF8.GetBytes(preHash));
            string output = "";
            foreach (byte b in hash)
            {
                output += (char) b;
            }
            Debug.WriteLine(output);
        }
    }
}
