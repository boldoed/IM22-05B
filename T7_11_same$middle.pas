program student_height;

type
   StudentGroup = record
    Name : string[20];
    Sex : string[1];
    height : integer;
    weight : integer;
   end;
   StudentFile = file of StudentGroup;

procedure addStudent(fileName : string);
var s : string;
    student : StudentGroup;
    f : StudentFile;
begin
  AssignFile(f, fileName);
  if not FileExists(fileName) then
    rewrite(f)
  else
    reset(f);
  seek(f, filesize(f));
  while true do
  begin
    writeln('Добавить нового студента? да/нет');
    readln(s);
    if s='да' then
    begin
      writeln('Введите фамилию:');
      readln(student.Name);
      writeln('Введите пол студента(м/ж):');
      readln(student.Sex);
      writeln('Введите рост студента:');
      readln(student.height);
      writeln('Введите вес студента:');
      readln(student.weight);
      write(f, student);
    end
    else
      break;
  end;
  closeFile(f);
end;

procedure listStudents(fileName:string);
var f:StudentFile;
  student:StudentGroup;
begin
  if FileExists(fileName) then
  begin
    assignFile(f, fileName);
    reset(f);
    writeln;
    writeln('Студенты:');
    while not Eof(f) do
    begin
      read(f, student);
      writeln(student.Name,' ', student.Sex,' ', student.height,' ', student.weight);
    end;
    closeFile(f);
  end;
end;

procedure HighestWoman(fileName:string);
var f:StudentFile;
  student:StudentGroup;
  middleW, count, maxH_i : integer;
  maxH_n : string := 'qwert';
begin
  if FileExists(fileName) then
  begin
    assignFile(f, fileName);
    reset(f);
    writeln;
    writeln('Девушка, которая при весе не выше среднего (среди девушек), самая высокая:');
    while not Eof(f) do
    begin
      read(f, student);
      if student.Sex = 'ж' then
        begin
        middleW += student.weight;
        count += 1;
        end;
    end;
    middleW := middleW div count;
    Seek(f, 0);
    while not Eof(f) do
    begin
      read(f, student);
      if (student.Sex = 'ж') and (student.weight <= middleW) and (student.height > maxH_i) then
        begin
        maxH_i := student.height;
        maxH_n := student.Name;
        end;
      end;
    closeFile(f);
  end;
  writeln(maxH_n, ', ее рост: ', maxH_i);
end;

procedure SameHaS(fileName:string);
var f:StudentFile;
  student:StudentGroup;
  man_h : array of integer;
  wom_h : array of integer;
  countM, countW : integer;
  same : boolean := False;
begin
  if FileExists(fileName) then
  begin
    assignFile(f, fileName);
    reset(f);
    writeln;
    while not Eof(f) do
    begin
      read(f, student);
      if student.Sex = 'м' then
      begin
        countM += 1;
        setlength(man_h, countM);
         if student.height in man_h then
          begin
            same := True;
            writeln('Нашлись два мужчины одного роста');
            break
          end;
        man_h[countM - 1] := student.height;
        end
      else if student.Sex = 'ж' then
        begin      
        countW += 1;
        setlength(wom_h, countW);
         if student.height in wom_h then
          begin
            same := True;
            writeln('Нашлись две женщины одного роста');
            break
          end;  
        wom_h[countW - 1] := student.height;          
        end;
    end;
    closeFile(f);
  end;
  if not same then
    writeln('Не нашлось студентов одного роста и пола');
end;

var
  student : StudentGroup;
  fileName : string;
begin
  fileName := 'd:\code_file\PABC\students.dat';
  addStudent(fileName);
  listStudents(fileName);
  HighestWoman(fileName);
  SameHaS(fileName);
end.