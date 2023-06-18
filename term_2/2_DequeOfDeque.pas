program DequeOfDeque;
  
type
    TSide = ^Side;
    Side = record
      name : string[16];
      left : TSide;
      right : TSide;
    end;

    TMain = ^Deque;
    Deque = record
      name : string[16];
      subHead : TSide;
      subTail : TSide;
      left : TMain;
      right : TMain;
    end;
    
var
    head, tail: TMain;
    mainLen: integer;


procedure viewDeck(head: TMain);
var 
  SubHead : TSide;
begin
    while head <> nil do
    begin
        writeln(head^.name);
        
        SubHead := head^.SubHead;
        while SubHead <> nil do
          begin
            
           writeln(' '* 4, SubHead^.name);
           
           SubHead := SubHead^.right;
          end;
        head := head^.right;
    end;
end;


procedure createSide(n : integer; var subHead, subTail : TSide);
var
    dummy, prev, cur: TSide;
begin
  new(dummy);
  prev := dummy;
  for var i := 1 to n do
  begin
      new(cur);
      cur^.name := 'Side number ' + inttostr(i);
      cur^.left := prev;
      prev^.right := cur;
      prev := cur;
  end;
  subTail := cur;
  subHead := dummy^.right;
  subHead^.left := nil;
end;


procedure createMain(n : integer;  var head, tail: TMain);
var
    dummy, prev, cur: TMain;
    count : integer;
begin
  new(dummy);
  prev := dummy;
  for var i := 1 to n do
  begin
      new(cur);
      writeln('Введите количество элементов в поддеке');
      readln(count);
      cur^.name := 'Main number ' + IntToStr(i) + ' ';
      createSide(count, cur^.subHead, cur^.subTail);
      cur^.left := prev;
      prev^.right := cur;
      prev := cur;
  end;
  tail := cur;
  head := dummy^.right;
  head^.left := nil;
end;
    


begin
  writeln('Введите количество главных деков: ');
  readln(mainLen);
  createMain(mainLen, head, tail);
  viewDeck(head);
end.