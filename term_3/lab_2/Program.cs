using System;

namespace Circle_Lab2
{
    public class Program
    {
        static void Main(string[] args)
        {
            const float PI = 3.14F;
            var circle1 = new TCircle(0, 0, 10, PI);
            //Console.WriteLine(circle1);
            Console.WriteLine(circle1.GetInfo());
        }
    }
}