using System;

namespace Circle_Lab3
{
    public class Program
    {
        static void Main(string[] args)
        {
            const float PI = 3.14F;
            var circle1 = new TCircle(0, 0, 10, PI);
            var apprcircle1 = new TApprCircle(0, 0, 10, PI, 6);
            Console.WriteLine(circle1.GetInfo());
            Console.WriteLine(apprcircle1.GetInfoAppr());
        }
    }
}