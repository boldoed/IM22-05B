﻿using System;

namespace Circle_Lab2
{
    public class TCircle
    {
        private int Xcoord;
        private int Ycoord;
        private int radius;
        private float PI;

        public TCircle(int Xcoord, int Ycoord, int radius, float PI)
        {
            this.Xcoord = Xcoord;
            this.Ycoord = Ycoord;
            this.radius = radius;
            this.PI = PI;
        }

        public int Radius
        {
            set
            {
                if (value <= 0)
                    Console.WriteLine("Радиус не может быть меньше нуля");
                else
                    radius = value;
            }
            get { return radius; }
        }

        public float GetCircleLength()
        {
            return (2 * PI * radius);
        }

        public float GetCircleArea()
        {
            return PI * radius * radius;
        }

        public string GetInfo()
        {
            string result = $"Информация об окружности:\n\tКоординаты центра: {this.Xcoord}, {this.Ycoord}" +
                            $"\n\tРадиус: {this.radius}" +
                            $"\n\tДлина окружности: {Math.Round(GetCircleLength(), 2)}" +
                            $"\n\tПлощадь круга: {Math.Round(GetCircleArea(), 2)}";
            return result;
        }

    }
}
