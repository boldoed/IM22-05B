program telegramma_file;

var
  s:string;
  f:TextFile;
  
function Translate(stroka : string) : string;
  begin
    stroka := stroka.Replace(' ЗПТ', ',');
    stroka := stroka.Replace(' ТЧК', '.');
    stroka := stroka.Replace(' ДВТ', ':');
    stroka := stroka.Replace(' ВСК', '!');
    stroka := stroka.Replace(' КВЧ', '"');
    stroka := stroka.Replace('КВЧ ', '"');
    stroka := stroka.Replace(' ДФС', ' -');
    result := stroka  
  end;
  
begin
  AssignFile(f,'D:\code_file\test_file.txt');
  Reset(f, Encoding.UTF8);
  while not Eof(f) do
  begin
    readln(f,s);
    writeln(Translate(s));
  end;
  CloseFile(f);
end.