using RestaurantManagement.DAO;
using RestaurantManagement.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RestaurantManagement
{
    public partial class TableManager : Form
    {
        public TableManager()
        {
            InitializeComponent();

            LoadTable();
        }

        #region Method
        void LoadTable()
        {
            List<Table> tableList = TableDAO.Instance.LoadTableList();

            foreach (Table item in tableList)
            {
                Button btn = new Button()
                {Width = TableDAO.TableWidth, Height = TableDAO.TableHeight };

                String status = item.Status != "NULL" ? item.Status : "Empty";
                btn.Text = item.Name + Environment.NewLine + status;
                btn.Click += Btn_Click;
                btn.Tag = item;

                switch(item.Status)
                {
                    case "NULL":
                        btn.BackColor = Color.LightSkyBlue;
                        break;
                    default:
                        btn.BackColor = Color.IndianRed;
                        break;
                }
                flpTable.Controls.Add(btn);
            }
        }

        void ShowBill(int id)
        {
            lsvBill.Items.Clear();
            List<MenuFood> listBillinfor = MenuDAO.Instance.GetListMenuByTable(id);

            float totalPrice = 0;
            foreach(MenuFood item in listBillinfor)
            {
                ListViewItem lsvItem = new ListViewItem(item.FoodName.ToString());
                lsvItem.SubItems.Add(item.Count.ToString());
                lsvItem.SubItems.Add(item.Price.ToString());
                lsvItem.SubItems.Add(item.TotalPrice.ToString());

                totalPrice += item.TotalPrice;
                lsvBill.Items.Add(lsvItem);
            }

            CultureInfo culture = new CultureInfo("vi-VN");
            //Thread.CurrentThread.CurrentCulture = culture;
            txbTotalPrice.Text = totalPrice.ToString("c",culture);
        }
        #endregion

        #region Events
        void Btn_Click(object sender, EventArgs e)
        {
            int tableID = ((sender as Button).Tag as Table).ID;
            ShowBill(tableID);
        }

        private void logOutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void personalInformationToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AccountProfile f = new AccountProfile();
            f.ShowDialog();
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            Admin f = new Admin();
            f.ShowDialog();
        }
        #endregion
    }
}
