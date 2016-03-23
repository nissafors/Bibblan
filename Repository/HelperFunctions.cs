using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Repository.EntityModels
{
    class HelperFunctions
    {
        /// <summary>
        /// Get a connection to the database.
        /// </summary>
        /// <returns>Returns a SqlConnection object.</returns>
        public static SqlConnection GetConnection()
        {
            var username = DBCredentials.Username;
            var password = DBCredentials.Password;
            return new SqlConnection(@"Data Source=bibblan.database.windows.net;Initial Catalog=BibblanDatabase;Integrated Security=False;User ID=" + username + ";Password=" + password + ";Connect Timeout=60;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");
        }

        /// <summary>
        /// Retain an objects value if set, but cast to DBNull if it is null.
        /// </summary>
        /// <param name="value">Any object.</param>
        /// <returns>Returns the object unchanged if set and DBNull.Value otherwise.</returns>
        static public object ValueOrDBNull(object value)
        {
            if (value != null)
            {
                return value;
            }
            else
            {
                return DBNull.Value;
            }
        }

        /// <summary>
        /// Modify a search string for use in a SQL statement.
        /// </summary>
        /// <param name="search">The raw search string.</param>
        /// <returns>Returns the modified search string.</returns>
        static public string SetupSearchString(string search)
        {
            string modifiedSearch = "%";
            foreach (char character in search)
            {
                if (char.IsWhiteSpace(character))
                {
                    modifiedSearch += "%";
                }
                else
                {
                    modifiedSearch += character;
                }
            }
            modifiedSearch += "%";

            return modifiedSearch;
        }

        /// <summary>
        /// Returns a list of strings that contains matches for strings in wanted fields
        /// </summary>
        /// <param name="reader"></param>
        /// <param name="wantedFields"></param>
        /// <returns></returns>
        public static List<string> hasFields(SqlDataReader reader, string[] wantedFields)
        {
            var fields = new List<string>();
            for (int i = 0; i < reader.FieldCount; i++)
            {
                foreach(var field in wantedFields)
                {
                    if (reader.GetName(i) == field)
                    {
                        fields.Add(field);
                        break;
                    }
                        
                }
            }
            return fields;
        }
    }
}
