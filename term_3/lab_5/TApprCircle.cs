using System;
using System.Runtime.CompilerServices;

namespace Circle_Lab4
{
    public class TApprCircle : TCircle
    {
        private int n;
        public float a;

        public TApprCircle(int Xcoord, int Ycoord, int radius, double PI, int n) : base(Xcoord, Ycoord, radius, PI)
        {
            this.n = n;

        }

        public float Perimeter()
        {
            a = (float)(2 * Radius / Math.Sin(Math.PI / n));
            return n * a;
        }

        public float Square()
        {
            return (float)(n * Math.Pow(Radius, 2) * Math.Tan(Math.PI / n));
        }

        public override string GetInfo()
        {
            string result = $"Информация об аппроксимированной окружности:\n\tКоличество сигментов: {n}" +
                            $"\n\tПериметр аппроксимированной окружности: {Math.Round(Perimeter(), 2)}" +
                            $"\n\tДлина стороны: {a}" +
                            $"\n\tПлощадь аппроксимированной окружности: {Math.Round(Square(), 2)}" +
                            $"\n\tКоординаты центра: x, y" +
                            $"\n\tРадиус: {Radius}" +
                            $"\n\tДлина окружности: {Math.Round(GetCircleLength(), 2)}" +
                            $"\n\tПлощадь круга: {Math.Round(GetCircleArea(), 2)}";
            return result;
        }
    }
}