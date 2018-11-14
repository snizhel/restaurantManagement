using RestaurantManagement.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RestaurantManagement.DAO
{
    public class MenuDAO
    {
        private static MenuDAO instance;

        public static MenuDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new MenuDAO();
                }
                return MenuDAO.instance;
            }
            private set
            {
                instance = value;
            }
        }

        private MenuDAO()
        { }

        public List<MenuFood> GetListMenuByTable(int id)
        {
            List<MenuFood> listMenu = new List<MenuFood>();
            string query = "select f.name, bi.count, f.Price, f.Price * bi.count as TotalPrice from dbo.BillInfo as bi, dbo.Bill as b, dbo.Food as f where bi.idBill = b.id and bi.idFood = f.id and b.status = 0 and b.idTable = " + id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                MenuFood menu = new MenuFood(item);
                listMenu.Add(menu);

            }

            return listMenu;
        }
    }
}
