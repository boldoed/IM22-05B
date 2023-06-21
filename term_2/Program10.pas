program kr;


type
  TMatrix = array of array of integer;

var
  Graph: TMatrix;
  GraphSm: TMatrix;

procedure InitGraph(var Graph: TMatrix; count_ver : integer);
var
  i, count_edge : integer;
begin
  setlength(Graph, count_ver);
  count_edge := random(count_ver + 1, round(count_ver * 1.5));
  for i := 0 to count_ver - 1 do
    setlength(Graph[i], count_edge);
end;

procedure RandFill(var Graph: TMatrix);
var 
  ran1 : integer;
  ran2 : integer;
begin
  for var i := 1 to length(Graph[1]) - 1 do
    begin
    ran1 := 0;
    ran2 := 0;
      while ran1 = ran2 do 
        begin
          ran1 := random(1, length(Graph) - 1);
          ran2 := random(1, length(Graph) - 1);
        end;
      Graph[ran1, i] := 1;
      Graph[ran2, i] := 1;
    end;
end;


procedure PrintMatrix(Graph: TMatrix);
begin
  for var i := 1 to length(Graph) - 1 do
  begin
    for var j := 1 to length(Graph[i]) - 1 do
    begin
      if Graph[i, j] = 1 then
        Write('1 ')
      else
        Write('0 ');
    end;
    Writeln;
  end;
end;

procedure IncToSme(Graph: TMatrix);
  begin
    setlength(GraphSm, length(Graph));
    for var i := 0 to length(Graph) - 1 do
      setlength(GraphSm[i], length(Graph));
      
    for var i := 1 to length(Graph[i]) - 1 do
      begin
        for var j := 1 to length(Graph) - 1 do
        begin
          if Graph[j, i] = 1 then
            Write(j, ' ')
            GraphSm();
//          else
//            Write('0 ');
        end;
        writeln;
      end;
  end;
  
var
  count_vert : integer;
begin
  write('Введите желаемое количество вершин: ');
  readln(count_vert);
  count_vert := count_vert + 1;
  InitGraph(Graph, count_vert);
  RandFill(Graph);
  PrintMatrix(Graph);
  IncToSme(Graph);
  writeln;
  PrintMatrix(GraphSm);
end.