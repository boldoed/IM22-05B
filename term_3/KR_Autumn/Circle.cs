using System;
using System.Runtime.CompilerServices;

namespace KR_Autumn
{
    public class Circle : Point
    {
        private int r;
        private string fill;

        public Circle(int x, int y, string color, int r, string fill) : base(x, y, color)
        {
            this.r = r;
            this.fill = fill;

        }
        public override string GetInfo()
        {
            string result = $"Объект: окружность" +
                            $"\n\tКоординаты центра: {this.x}, {this.y}" +
                            $"\n\tРадиус: {this.r}" +
                            $"\n\tЦвет: {this.color}" +
                            $"\n\tЗакрашено: {this.fill}";
            return result;
        }
        public override double FindLen()
        {
            return 2 * Math.PI * this.r;
        }
        public override double FindArea()
        {
            return Math.PI * Math.Pow(this.r, 2);
        }
    }
}