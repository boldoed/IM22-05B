namespace TelegrammaTCHK
{
    public class Telegramma
    {

        public string TelegrammaWrite(string teleStr) 
        {
            teleStr = telegrammaAnswer(teleStr);
            return teleStr;
        }
        private string telegrammaAnswer(string teleStr)
        {
            string answer = "";
            answer = teleStr.Replace(" ЗПТ", ",");
            answer = answer.Replace(" ТЧК", ".");
            answer = answer.Replace(" ДВТ", ":");
            answer = answer.Replace(" ВСК", "!");
            answer = answer.Replace(" КВЧ", "'");
            answer = answer.Replace("КВЧ ", "'");
            answer = answer.Replace(" ДФС", " -");
            return answer;

        }
    }
}
