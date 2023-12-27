using System;
using System.Runtime.CompilerServices;
using static System.Net.Mime.MediaTypeNames;

namespace KR_Autumn
{
    public class Image : Point
    {
        private List<Point> PointItems;
        public int p;
        public int l;
        public int c;
        public int i;

        public Image(int x, int y, string color) : base(x, y, color)
        {
            this.PointItems = new List<Point>();
        }

        public void LoadFromFile(string path)
        {
            foreach (string line in File.ReadLines(path))
            {
                var data = line.Split();
                if (data[0] == "point") 
                {
                    p += 1;
                    PointItems.Add(new Point(int.Parse(data[1]), int.Parse(data[2]), data[3]));
                } else if (data[0] == "line")
                {
                    l += 1;
                    PointItems.Add(new Line(int.Parse(data[1]), int.Parse(data[2]), data[3], int.Parse(data[4]), int.Parse(data[5]), int.Parse(data[6])));
                } else if (data[0] == "circle")
                {
                    c += 1;
                    if (int.Parse(data[5]) ==  0)
                    {
                        PointItems.Add(new Circle(int.Parse(data[1]), int.Parse(data[2]), data[3], int.Parse(data[4]), "нет"));
                    }
                    else
                    {
                        PointItems.Add(new Circle(int.Parse(data[1]), int.Parse(data[2]), data[3], int.Parse(data[4]), "да"));
                    }
                } else if (data[0] == "image")
                {
                    i += 1;
                    var img = new Image(int.Parse(data[1]), int.Parse(data[2]), data[3]);
                    img.LoadFromFile($"C:\\Users\\dania\\Downloads\\{data[4]}");
                    PointItems.Add(img);
                }
            }
        }
        public List<Point> LoadList()
        {
            return PointItems;
        }
        public override string GetInfo()
        {
            string result = "";

            foreach (var item in this.PointItems)
            {
                result += $"\n\t{item.GetInfo()}";
            }

            return $"Объект: изображение \n[{result}\n]";
        }
        public override double FindLen()
        {
            double SumLen;
            SumLen = 0;
            foreach (var item in this.PointItems)
            {
                SumLen += item.FindLen();
            }
            return SumLen;
        }
        public override double FindArea()
        {
            double SumArea;
            SumArea = 0;
            foreach (var item in this.PointItems)
            {
                SumArea += item.FindArea();
            }
            return SumArea;
        }
        public string CountObj()
        {
            string result = $"Количество объектов каждого класса:" +
                            $"\n\tТочка: {p}" +
                            $"\n\tЛиния: {l}" +
                            $"\n\tОкружность: {c}" +
                            $"\n\tИзображение: {i}";
            return result;
        }
    }
}