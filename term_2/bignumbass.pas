program Add10Numbers;

type
  TDeque = record
    Data: array of Integer;
  end;


procedure InitializeDeque(var deque: TDeque);
begin
  SetLength(deque.Data, 0);
end;


procedure PushFront(var deque: TDeque; value: Integer);
var
  i: Integer;
begin
  SetLength(deque.Data, Length(deque.Data) + 1);
  for i := High(deque.Data) downto 1 do
    deque.Data[i] := deque.Data[i - 1];
  deque.Data[0] := value;
end;


procedure PushBack(var deque: TDeque; value: Integer);
begin
  SetLength(deque.Data, Length(deque.Data) + 1);
  deque.Data[High(deque.Data)] := value;
end;

function IsDequeEmpty(const deque: TDeque): Boolean;
begin
  Result := Length(deque.Data) = 0;
end;


function SumBNBN(num1, num2: TDeque): TDeque;
var
  carry, digitSum, i: Integer;
begin
  InitializeDeque(result);
  while Length(num1.Data) < Length(num2.Data) do
    PushFront(num1, 0);
  while Length(num2.Data) < Length(num1.Data) do
    PushFront(num2, 0);
  carry := 0;
  for i := Length(num1.Data) - 1 downto 0 do
  begin
    digitSum := num1.Data[i] + num2.Data[i] + carry;
    carry := digitSum div 10;
    PushFront(result, digitSum mod 10);
  end;
  if carry <> 0 then
    PushFront(result, carry);
  Result := result;
end;


procedure PrintDeque(const deque: TDeque);
var
  i: Integer;
begin
  if IsDequeEmpty(deque) then
  begin
    Write('0');
    Exit;
  end;
  for i := 0 to High(deque.Data) do
    Write(deque.Data[i]);
end;


function MultiplyBigNumberByNumber(const bigNumber: TDeque; number: Integer): TDeque;
var
  carry, product: Integer;
  i: Integer;
begin
  InitializeDeque(result);
  carry := 0;
  for i := Length(bigNumber.Data) - 1 downto 0 do
  begin
    product := bigNumber.Data[i] * number + carry;
    PushFront(result, product mod 10);
    carry := product div 10;
  end;

  while carry > 0 do
  begin
    PushFront(result, carry mod 10);
    carry := carry div 10;
  end;
  Result := result;
end;


function SumBNN(const bigNumber: TDeque; number: Integer): TDeque;
var
  carry, sum: Integer;
  i: Integer;
begin
  InitializeDeque(result);
  carry := 0;
  for i := Length(bigNumber.Data) - 1 downto 0 do
  begin
    sum := carry + bigNumber.Data[i] + number mod 10;
    PushFront(result, sum mod 10);
    carry := sum div 10;
    number := number div 10;
  end;
  while number > 0 do
  begin
    sum := carry + number mod 10;
    PushFront(result, sum mod 10);
    carry := sum div 10;
    number := number div 10;
  end;
  if carry > 0 then
    PushFront(result, carry);
  Result := result;
end;


function MultiplyBigNumbers(const num1, num2: TDeque): TDeque;
var
  partialResult: TDeque;
  i, j: Integer;
begin
  InitializeDeque(result);
  for i := Length(num2.Data) - 1 downto 0 do
  begin
    partialResult := MultiplyBigNumberByNumber(num1, num2.Data[i]);
    for j := 0 to Length(num2.Data) - i - 2 do
      PushFront(partialResult, 0);
    result := SumBNBN(result, partialResult);
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
      Result := False; // Найден ненулевой элемент, возвращаем False
      Exit;
    end;
  end;
  Result := True; // Все элементы равны нулю, возвращаем True
end;


function DegNBN(base, deg: TDeque): TDeque;
begin
  InitializeDeque(result);
  result := base;
  deg := SumBNN(deg, -1);
  while not DeqZero(deg) do
  begin
    deg := SumBNN(deg, -1);
    result := MultiplyBigNumbers(result, base);
  end;
  Result := result;
end;


function DivideBigNumberByNumber(const deque: TDeque; number: Integer): TDeque;
var
  quotient: TDeque;
  remainder, i: Integer;
begin
  InitializeDeque(quotient);
  remainder := 0;

  for i := 0 to High(deque.Data) do
  begin
    remainder := remainder * 10 + deque.Data[i];
    PushBack(quotient, remainder div number);
    remainder := remainder mod number;
  end;

  // Удаляем ведущие нули в частном
  while (not IsDequeEmpty(quotient)) and (quotient.Data[High(quotient.Data)] = 0) do
    SetLength(quotient.Data, Length(quotient.Data) - 1);

  Result := quotient;
end;



var
  number1, deg_l, deg_r, left, right, leftAns : TDeque;
  digit : Char;
begin
  InitializeDeque(number1);
  InitializeDeque(deg_l);
  InitializeDeque(deg_r);
  InitializeDeque(left);
  InitializeDeque(right);
  InitializeDeque(leftAns);

  // Вводим первое большое число
  Write('Введите первое число: ');
  while not Eoln do
  begin
    Read(digit);
    PushBack(number1, StrToInt(digit));
  end;
  Readln;

  
  left := MultiplyBigNumberByNumber(number1, 5);
  PrintDeque(left);
  writeln;
  left := SumBNN(left, 1);
  PrintDeque(left);
  writeln;
  PushBack(deg_l, 2);
  left := DegNBN(deg_l, left);
  PrintDeque(left);
  
  writeln;
  writeln;
  
  right := SumBNN(number1, 2);
  PushBack(deg_r, 5);
  right := DegNBN(deg_r, right);
  PrintDeque(right);
  
  writeln;
  writeln;
  
  leftAns := SumBNBN(left, right);
  PrintDeque(leftAns);
  
  writeln;
  
  leftAns := DivideBigNumberByNumber(leftAns, 27);
  
  PrintDeque(leftAns);
end.
