program Wave_algorithm;

const
  COUNT_VERT = 5;
  
type
  TMatrix = array[1..COUNT_VERT, 1..COUNT_VERT] of integer;

var
  Graph: TMatrix;
  
procedure BuildMatrix(var Graph: TMatrix);
begin
  for var i := 1 to COUNT_VERT do
    for var j := 1 to COUNT_VERT do
      Graph[i, j] := 0;
end;

procedure RandomFill(var Graph: TMatrix);
begin
  for var i := 1 to COUNT_VERT do
    for var j := i+1 to COUNT_VERT do
      if Random(2) = 1 then
        begin
          Graph[i, j] := 1;
          Graph[j, i] := 1;
        end;
end;

procedure PrintMatrix(Graph: TMatrix);
begin
  for var i := 1 to COUNT_VERT do
  begin
    for var j := 1 to COUNT_VERT do
    begin
      if Graph[i, j] = 1 then
        Write('1 ')
      else
        Write('0 ');
    end;
    Writeln;
  end;
end;

procedure WaveAlgorithm(Graph: TMatrix; startVert: integer);
var
  Queue: array[1..COUNT_VERT] of integer;
  Visit: array[1..COUNT_VERT] of integer;
  Dist: array[1..COUNT_VERT] of integer;
  i, front, back, СhoseVert, SosedVert: integer;
begin
  for i := 1 to COUNT_VERT do
  begin
    Queue[i] := 0;
    Visit[i] := 0;
    Dist[i] := 0;
  end;

  Queue[1] := startVert;
  Visit[startVert] := 1;
  back := 1;
  
  front := 1;
  while front <= back do
  begin
    СhoseVert := Queue[front];
    for SosedVert := 1 to COUNT_VERT do
    begin
      if Graph[СhoseVert, SosedVert] and (not Visit[SosedVert]) = 1 then
      begin
        back += 1;
        Queue[back] := SosedVert;
        Visit[SosedVert] := 1;
        Dist[SosedVert] := Dist[СhoseVert] + 1;
      end;
    end;
    front += 1;
  end;
  
  for i := 1 to COUNT_VERT do
    Writeln('Расстояние от вершины ', startVert, ' до вершины ', i, ' -- ', Dist[i]);
end;

begin
  BuildMatrix(Graph);
  RandomFill(Graph);
  PrintMatrix(Graph);
  WaveAlgorithm(Graph, 1);
end.
