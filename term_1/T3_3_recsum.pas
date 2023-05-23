program rec_sum;

function R_Sum(n : integer) : integer;
  begin
    if n = 0 then
      R_Sum := 0
    else 
      R_Sum := (n mod 10) + R_Sum(n div 10);
  end;
  
begin
  var n : integer;
  writeln('Для какого числа вы хотите посчитать сумму цифр? Введите его.');
  readln(n);
  writeln(R_Sum(n))
end.
