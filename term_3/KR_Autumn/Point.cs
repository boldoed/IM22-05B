using System;

namespace KR_Autumn
{
    public class Point
    {
        protected int x;
        protected int y;
        protected string color;

        public Point(int x, int y, string color)
        {
            this.x = x;
            this.y = y;
            this.color = color;
        }
        public virtual string GetInfo()
        {
            string result = $"Объект: точка" +
                            $"\n\tКоординаты: {this.x}, {this.y}" +
                            $"\n\tЦвет: {this.color}";
            return result;
        }
        public virtual double FindLen()
        {
            return 0;
        }
        public virtual double FindArea()
        {
            return 0;
        }
    }
}