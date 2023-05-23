program matrix;

var 
  n, k, error, sum_elem, dinamic_sum_i, dinamic_sum_j : integer;
  stroka : string;
  stroka_mas : array of string;
  matrixx : array[,] of integer;
  flag : boolean := True;
  
begin
  writeln('Введите размерность матрицы');
  readln(n);
  setlength(matrixx, n, n);
  for var i:=0 to n - 1 do
    begin
      writeln('Введите ', i + 1, '-ю строку из ', i + 1, ' символов');
      readln(stroka);
      stroka_mas := stroka.Split();
      for var j := 0 to n - 1 do
        begin
          val(stroka_mas[j], k, error);
          matrixx[i, j] := k;
        end;
    end;
    
    for var i := 0 to n - 1 do
      begin
        for var j := 0 to n - 1 do
          begin
            if i = 0 then
              sum_elem += matrixx[i, j];
            dinamic_sum_i += matrixx[i, j];
            dinamic_sum_j += matrixx[j, i];
          end;
        if (dinamic_sum_i <> sum_elem) or (dinamic_sum_j <> sum_elem) then
          begin
            writeln('Не является магическим квадратом');
            flag := False;
            break
          end;
        dinamic_sum_i := 0;
        dinamic_sum_J := 0;
      end;
    if flag then
      writeln('Магический квадрат!!!');
end.
