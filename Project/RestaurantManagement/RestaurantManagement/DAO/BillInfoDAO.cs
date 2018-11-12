using RestaurantManagement.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantManagement.DAO
{
    public class BillInfoDAO
    {
        private static BillInfoDAO instance;

        public static BillInfoDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new BillInfoDAO();
                }
                return BillInfoDAO.instance;
            }
            private set
            {
                instance = value;
            }
        }

        private BillInfoDAO()
        { }

        public List<BillInfo> GetListBillInfor(int id)
        {
            List<BillInfo> listBillInfor = new List<BillInfo>();

            DataTable data = DataProvider.Instance.ExecuteQuery("select * from dbo.BillInfo where idBill =  " + id);

            foreach(DataRow item in data.Rows)
            {
                BillInfo infor = new BillInfo(item);
                listBillInfor.Add(infor);
            }

            return listBillInfor;
        }

        public void InsertBillInfo(int idBill, int idFood, int count)
        {
            DataProvider.Instance.ExecuteNonQuery("exec usp_InsertBillInfo @idBill , @idFood , @count ", new object[] { idBill, idFood, count });
        }
    }
}
