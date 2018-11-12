using RestaurantManagement.DAO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RestaurantManagement
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }
        
        bool Signin(string userName, string passWord)
        {
            return AccountDAO.Instance.Signin(userName, passWord);
        }

        private void Login_FormClosing(object sender, FormClosingEventArgs e)
        {
            if(MessageBox.Show("Do you want to exit the program?", "Notification!" ,MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }

        private void btnExit_Click_1(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void MyLogin()
        {
            string userName = txbUserName.Text;
            string passWord = txbPassWord.Text;
            if (Signin(userName, passWord))
            {
                TableManager f = new TableManager();
                this.Hide();
                f.ShowDialog();
                this.Show();
            }
            else
            {
                MessageBox.Show("Incorrect UserName or Password.", "Error!");
            }
        }

        private void btnLogin_Click_1(object sender, EventArgs e)
        {
            MyLogin();
        }

        private void bunifuImageButton1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            MyLogin();
        }
    }
}
