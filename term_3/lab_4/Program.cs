using System;
using System.ComponentModel.DataAnnotations;
using System.IO;

namespace Circle_Lab4
{
    public class Program
    {
        static void Main(string[] args)
        {
            TContainer container = new TContainer();
            var path = "C:\\Users\\dania\\source\\repos\\LAB_4\\LAB_4\\text.txt";
            container.LoadFromFile(path);
            foreach (var elem in container.LoadList())
            {
                Console.WriteLine(elem.GetInfo());
            }

        }
    }
}