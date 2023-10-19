using System;


namespace TelegrammaTCHK
{
    public class Program
    {
        static void Main(string[] args)
        {
            var telegramma = new Telegramma();
            while (true)
            {
                Console.Write("Введите текст: ");
                string text = Console.ReadLine();
                if (text.Length != 0)
                {
                    Console.WriteLine(telegramma.TelegrammaWrite(text));
                }
                else
                {
                    Console.WriteLine("Вы ничего не ввели.");
                    break;
                }
            }
        }
    }
}