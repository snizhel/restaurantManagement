using RestaurantManagement.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantManagement.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;

        public static BillDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new BillDAO();
                }
                return instance;
            }
            private set { instance = value; }
        }

        private BillDAO()
        { }

        /// <summary>
        /// Success bill ID
        /// Fail -1
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int GetUncheckBillIDByTableID(int id)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("select * from dbo.Bill where idTable = " + id +" and status = 0");

            if (data.Rows.Count>0)          //số trường trả về > 0
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;             // lấy id của bill
            }
            return -1;                      // id = -1 là ko có j hết
        }
    }
}
