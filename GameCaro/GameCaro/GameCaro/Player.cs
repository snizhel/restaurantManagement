using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameCaro
{
    //tao ten va hinh anh cho nguoi choi
    public class Player
    {
        private string name;

        public string Name
        {
            get => name;
            set => name = value;
        }

        private Image mark;

        public Image Mark
        {
            get => mark;
            set => mark = value;
        }

        // Constructor nay gom 2 tham so 
        // Muc dich de khoi tao cac gia tri cho cac truong cua Player
        public Player(string name, Image mark)
        {
            this.Name = name;
            this.Mark = mark;
        }
    }
}
