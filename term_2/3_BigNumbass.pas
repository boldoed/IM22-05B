program BigNum;

type
  TDeque = record
    Data: array of Integer;
  end;


procedure InitDeque(var deque: TDeque);
begin
  SetLength(deque.Data, 0);
end;


procedure PushLeft(var deque: TDeque; val: Integer);
var
  i: Integer;
begin
  SetLength(deque.Data, Length(deque.Data) + 1);
  for i := length(deque.Data) - 1 downto 1 do
    deque.Data[i] := deque.Data[i - 1];
  deque.Data[0] := val;
end;


procedure PushRight(var deque: TDeque; val: Integer);
begin
  SetLength(deque.Data, Length(deque.Data) + 1);
  deque.Data[length(deque.Data) - 1] := val;
end;


function IsDequeZero(deque: TDeque): Boolean;
begin
  Result := Length(deque.Data) = 0;
end;


function SumBNBN(num1, num2: TDeque): TDeque;
var
  carry, digitSum, i: Integer;
begin
  InitDeque(result);
  while Length(num1.Data) < Length(num2.Data) do
    PushLeft(num1, 0);
  while Length(num2.Data) < Length(num1.Data) do
    PushLeft(num2, 0);
  carry := 0;
  for i := Length(num1.Data) - 1 downto 0 do
  begin
    digitSum := num1.Data[i] + num2.Data[i] + carry;
    carry := digitSum div 10;
    PushLeft(result, digitSum mod 10);
  end;
  if carry <> 0 then
    PushLeft(result, carry);
  Result := result;
end;


procedure PrintDeque(const deque: TDeque);
var
  i: Integer;
begin
  if IsDequeZero(deque) then
  begin
    Write('0');
    Exit;
  end;
  for i := 0 to length(deque.Data) - 1 do
    Write(deque.Data[i]);
end;


function MultiplyBNN(bigNumber: TDeque; number: Integer): TDeque;
var
  carry, product: Integer;
  i: Integer;
begin
  InitDeque(result);
  carry := 0;
  for i := Length(bigNumber.Data) - 1 downto 0 do
  begin
    product := bigNumber.Data[i] * number + carry;
    PushLeft(result, product mod 10);
    carry := product div 10;
  end;
  while carry > 0 do
  begin
    PushLeft(result, carry mod 10);
    carry := carry div 10;
  end;
  Result := result;
end;


function SumBNN(bigNumber: TDeque; number: Integer): TDeque;
var
  carry, sum: Integer;
  i: Integer;
begin
  InitDeque(result);
  carry := 0;
  for i := Length(bigNumber.Data) - 1 downto 0 do
  begin
    sum := carry + bigNumber.Data[i] + number mod 10;
    PushLeft(result, sum mod 10);
    carry := sum div 10;
    number := number div 10;
  end;
  while number > 0 do
  begin
    sum := carry + number mod 10;
    PushLeft(result, sum mod 10);
    carry := sum div 10;
    number := number div 10;
  end;
  if carry > 0 then
    PushLeft(result, carry);
  Result := result;
end;


function MultiplyBNBN(num1, num2: TDeque): TDeque;
var
  preResult: TDeque;
  i, j: Integer;
begin
  InitDeque(result);
  for i := Length(num2.Data) - 1 downto 0 do
  begin
    preResult := MultiplyBNN(num1, num2.Data[i]);
    for j := 0 to Length(num2.Data) - i - 2 do
      PushLeft(preResult, 0);
    result := SumBNBN(result, preResult);
  end;
  Result := result;
end;


function DeqZero(deque: TDeque): Boolean;
var
  i: Integer;
begin
  for i := 0 to Length(deque.Data) - 1 do
  begin
    if deque.Data[i] <> 0 then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;


function DegNBN(base, deg: TDeque): TDeque;
begin
  InitDeque(result);
  result := base;
  deg := SumBNN(deg, -1);
  while not DeqZero(deg) do
  begin
    deg := SumBNN(deg, -1);
    result := MultiplyBNBN(result, base);
  end;
  Result := result;
end;


function DivideBNN(deque: TDeque; number: Integer): TDeque;
var
  quotient: TDeque;
  remainder, i: Integer;
begin
  InitDeque(quotient);
  remainder := 0;
  for i := 0 to length(deque.Data) - 1 do
  begin
    remainder := remainder * 10 + deque.Data[i];
    PushRight(quotient, remainder div number);
    remainder := remainder mod number;
  end;
  Result := quotient;
end;



var
  number1, deg_l, deg_r, left, right, leftAns : TDeque;
  digit : Char;
begin
  InitDeque(number1);
  InitDeque(deg_l);
  InitDeque(deg_r);
  InitDeque(left);
  InitDeque(right);
  InitDeque(leftAns);

  // Вводим первое большое число
  Write('Введите n: ');
  while not Eoln do
  begin
    Read(digit);
    PushRight(number1, StrToInt(digit));
  end;
  Readln;

  
  left := MultiplyBNN(number1, 5);
//  PrintDeque(left);
//  writeln;
  left := SumBNN(left, 1);
//  PrintDeque(left);
//  writeln;
  PushRight(deg_l, 2);
  left := DegNBN(deg_l, left);
//  PrintDeque(left);
  
//  writeln;
//  writeln;
  
  right := SumBNN(number1, 2);
  PushRight(deg_r, 5);
  right := DegNBN(deg_r, right);
//  PrintDeque(right);
  
//  writeln;
//  writeln;
  
  leftAns := SumBNBN(left, right);
  write('Левая часть выражения 2^(5*n+1)+5^(n+2) = ');
  PrintDeque(leftAns);
  
  writeln;
  
  leftAns := DivideBNN(leftAns, 27);
  
  write('k = ');
  PrintDeque(leftAns);
end.
