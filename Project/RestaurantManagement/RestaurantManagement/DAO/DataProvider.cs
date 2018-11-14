using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantManagement.DAO
{
    public class DataProvider
    {
        private static DataProvider instance;
        public static DataProvider Instance             //Design Pattern Singleton chỉ có duy nhất 1 thằng thể hiện của DataProvider tồn tại trong chương trình
        {
            get
            {
                if (instance == null)
                {
                    instance = new DataProvider();
                }
                return DataProvider.instance;
            }
            private set { DataProvider.instance = value; }
        }

        private DataProvider()                      // hàm dựng để đảm bao bên ngoài ko thể tác động dc chỉ lấy ra thôi.
        {}

        private string connectionSTR = "Data Source=DESKTOP-EAREARJ;Initial Catalog=RestaurantManagement;Integrated Security=True";

        public DataTable ExecuteQuery(string query, object[] parameter = null)  //trả ra những dòng kết quả
        {
            DataTable data = new DataTable();                                   //DataProvider trả ra DataTable
            using (SqlConnection connection = new SqlConnection(connectionSTR)) //using khi kết thúc khối lệnh rồi thì dữ liệu khai
            {                                                                   //báo ở đây sẽ tự đc giải phóng   
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);         //để thực hiện query trên connection(câu truy vấn để thực thi)

                if (parameter != null)                                          // add dc n parameter
                {
                    string[] listPara = query.Split(new Char[] {' ', ','});
                    int i = 0;
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            string text = parameter[i].ToString();
                            command.Parameters.AddWithValue(item, text);
                            i++;
                        }
                    }
                }

                SqlDataAdapter adapter = new SqlDataAdapter(command);           //trung gian thực hiện câu truy vấn để lấy dữ liệu ra

                adapter.Fill(data);                                             //đổ dữ liệu lấy ra vào data

                connection.Close();
            }    
            return data;
        }

        public int ExecuteNonQuery(string query, object[] parameter = null)                //kết quả sau khi insert,update or delete
        {                                                                                  //trả ra số dòng dc thực thi        
            int data = 0;                               
            using (SqlConnection connection = new SqlConnection(connectionSTR)) 
            {                                                               
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);     

                if (parameter != null)                                       
                {
                    string[] listPara = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }
                    }
                }
                data = command.ExecuteNonQuery();

                connection.Close();
            }
            return data;
        }

        public object ExecuteScalar(string query, object[] parameter = null)               //cần số lượng trả ra cho select *
        {                                                                       
            object data = 0;
            using (SqlConnection connection = new SqlConnection(connectionSTR))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);

                if (parameter != null)
                {
                    string[] listPara = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }
                    }
                }
                data = command.ExecuteScalar();

                connection.Close();
            }
            return data;
        }
    }
}
