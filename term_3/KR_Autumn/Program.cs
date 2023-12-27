using System;
using System.Security.Cryptography.X509Certificates;

namespace KR_Autumn
{
    public class Program
    {
        static void Main(string[] args)
        {
            Image container = new Image(0, 0, "");
            var path = "C:\\Users\\dania\\Downloads\\text1.txt";
            container.LoadFromFile(path);
            foreach (var elem in container.LoadList())
            {
                Console.WriteLine(elem.GetInfo());
            }
            Console.WriteLine($"Общая длина линий всех объектов: {Math.Round(container.FindLen(), 2)}");
            Console.WriteLine($"Общая площадь всех объектов: {Math.Round(container.FindArea(), 2)}");
            Console.WriteLine(container.CountObj());
        }
    }
}