program telegramma;

function Translate(stroka : string) : string;
  begin
    stroka := stroka.Replace(' ЗПТ', ',');
    stroka := stroka.Replace(' ТЧК', '.');
    result := stroka
  end;
  
var 
  stroka : string; 
begin
  writeln('Введите текст для перевода');
  readln(stroka); 
  writeln(Translate(stroka));
end.
