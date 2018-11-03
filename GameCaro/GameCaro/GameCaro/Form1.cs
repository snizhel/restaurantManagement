using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GameCaro
{
    public partial class Form1 : Form
    {
        #region Properties
        ChessBoardManager ChessBoard;
        #endregion

        public Form1()
        {
            InitializeComponent();
            ChessBoard = new ChessBoardManager(pnlChessBoard, txbPlayerName, pctbMark);

            prcbCountDown.Step = Cons.CountDownStep;
            prcbCountDown.Maximum = Cons.CountDownTime;
            prcbCountDown.Value = 0;
            tmCountDown.Interval = Cons.CountDownInterval;

            ChessBoard.DrawChessBoard();
            tmCountDown.Start();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void progressBar1_Click(object sender, EventArgs e)
        {

        }

        private void tmCountDown_Tick(object sender, EventArgs e)
        {
            prcbCountDown.PerformStep();
        }
    }
}
