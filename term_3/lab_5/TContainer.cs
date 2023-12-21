using System;

namespace Circle_Lab4
{
    public class TContainer
    {
        public List<TCircle> Circles = new List<TCircle>();

        public void AddCircle(TCircle circle)
        {
            this.Circles.Add(circle);
        }

        public void LoadFromFile(string path)
        {
            foreach (string line in File.ReadLines(path))
            {
                var data = line.Split();
                int Xcoord = int.Parse(data[0]);
                int Ycoord = int.Parse(data[1]);
                int radius = int.Parse(data[2]);
                if (data.Length == 4)
                {
                    int n = int.Parse(data[3]);
                    var apprcircle1 = new TApprCircle(Xcoord, Ycoord, radius, Math.PI, n);
                    AddCircle(apprcircle1);
                }
                else if (data.Length == 3)
                {
                    var circle1 = new TCircle(Xcoord, Ycoord, radius, Math.PI);
                    AddCircle(circle1);
                }
            }
        }

        public List<TCircle> LoadList()
        {
            return Circles;
        }

        public int MaxRadius()
        {
            int maxrad = 0;
            foreach (TCircle circle in Circles)
            {
                if (circle.Radius >= maxrad)
                {
                    maxrad = circle.Radius;
                }
            }
            foreach (TCircle circle in Circles)
            {
                if (circle.Radius == maxrad) { maxrad = circle.Radius; }
            }
            return maxrad;
        }

        public List<TCircle> SortCont()
        {
            List<TCircle> SortedList = Circles.OrderBy(circle => circle.Radius).ToList();
            return SortedList;
        }

    }
}
