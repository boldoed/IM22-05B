using System;
using System.Runtime.CompilerServices;

namespace KR_Autumn
{
    public class Line : Point
    {
        private int x2;
        private int y2;
        private int width;

        public Line(int x, int y, string color, int x2, int y2, int width) : base(x, y, color)
        {
            this.x2 = x2;
            this.y2 = y2;
            this.width = width;

        }
        public override string GetInfo()
        {
            string result = $"Объект: линия" +
                            $"\n\tКоординаты начала: {this.x}, {this.y}" +
                            $"\n\tКоординаты конца: {this.x2}, {this.y2}" +
                            $"\n\tЦвет: {this.color}" +
                            $"\n\tШирина: {this.width}";
            return result;
        }

        public override double FindLen()
        {
            return Math.Sqrt(Math.Pow(this.x2-this.x, 2) + Math.Pow(this.y2 - this.y, 2));
        }
        public override double FindArea()
        {
            return FindLen() * this.width;
        }
    }
}