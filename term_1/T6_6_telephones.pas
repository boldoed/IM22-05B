program Mvideo;

type
SmartPhones=record
  firm: string;
  model: string;
  memory: integer;
end;
TGruppa = array of SmartPhones;

procedure AddPhones (var gr: Tgruppa);
  var
    n: integer;
  begin
    n:=length(gr);
    SetLength(gr, n+1);
    writeln('Введите фирму (например "Apple")');
    readln(gr[n].firm);
    writeln('Введите модель');
    readln(gr[n].model);
    writeln('Введите объем памяти');
    readln(gr[n].memory);
  end;

procedure PrintPhones (gr:TGruppa);
  var
    i: integer;
  begin
    if length(gr)=0  then
      writeln('Список пуст')
      else
      begin
        writeln('Фирма':15,'Модель':15,'Память':15);
        for i:=0 to Length(gr)-1  do
         writeln(gr[i].firm:15,  gr[i].model:15,  gr[i].memory:15);
      end;
  end;

// procedure RemovePhones(var gr:TGruppa);
// var
// K, i : integer;
// s : string;
// begin
// k := 0;
//   writeln('Введите какую фирму хотите удалить');
//   readln(s);
//   for i := 0 to length(gr) - 1 do
//   begin
//    if gr[i].fir = s then
//    begin
//     k := i;
//     break;
//    end;
//   end;
//   if k=0 then
//   writeln('Такой фирмы нет')
//   else
//   begin
//  for i := k+1 to Length(gr) - 1 do
//    gr[i - 1] := gr[i];
//  SetLength(gr, length(gr) - 1);
//   end;
// end;
 
procedure SearchPhones(var gr: Tgruppa);
  var
    n: string;
    flag : boolean := false;
  begin
    writeln('Введите модель телефона');
    readln(n);
    writeln('Фирма':15,'Модель':15,'Память':15);
    for var i:=0 to Length(gr)-1  do
      begin
        if gr[i].model = n then
          begin
          writeln(gr[i].firm:15,  gr[i].model:15,  gr[i].memory:15);
          flag := true;
          end;
      end;
    if not flag then
      writeln('Совпадений не найдено');
  end;


var
Gruppa: TGruppa;
a: integer;

begin
  repeat
  Writeln('Введите номер нужной операции: ');
  Writeln('1 - добавить телефон');
  Writeln('2 - Распечатать список телефонов');
  Writeln('3 - Найти телефон по названию модели');
  Writeln('0 - выход');
  readln(a);
  if a=1 then
    AddPhones(Gruppa);
  if a=2 then
    PrintPhones(Gruppa);
  if a=3 then
    SearchPhones(Gruppa);
  until (a=0);
  Readln;
end.
