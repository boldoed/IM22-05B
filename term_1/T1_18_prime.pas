program prime;

var 
 n : integer;
 k : boolean;
begin
  Writeln('Ведите N');
  readln(n);
  writeln('Простые числа из диапазона [2, N]:');
  writeln(2);
  for var i := 2 to n do
    begin
      k := True;
      for var j := 2 to Ceil(i ** 0.5) do
        begin
        if Frac(i / j) = 0 then
          k := False;
        end;
      if k then 
        writeln(i);
    end;
end.
