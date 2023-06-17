program Wave_Algorithm;

const
  COUNT_VERT = 5;

type
  TMatrix = array[1..COUNT_VERT, 1..COUNT_VERT] of integer;

var
  Graph: TMatrix;

procedure InitGraph(var Graph: TMatrix);
var
  i, j: integer;
begin
  for i := 1 to COUNT_VERT do
    for j := 1 to COUNT_VERT do
      Graph[i, j] := 0;
end;

procedure AddEdge(var Graph: TMatrix; vert1, vert2: integer);
begin
  Graph[vert1, vert2] := 1;
  Graph[vert2, vert1] := 1;
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

procedure WaveAlgorithm(Graph: TMatrix; startVert, finishVert: integer);
var
  Visit: array[1..COUNT_VERT] of integer;
  Queue: array[1..COUNT_VERT] of integer;
  Dist: array[1..COUNT_VERT] of integer;
  Path: array[1..COUNT_VERT] of integer;
  front, next, currVert, sosedVert: integer;
  pathFound: boolean;
  pathLength: integer;
begin
  // Инициализация
  for currVert := 1 to COUNT_VERT do
  begin
    Visit[currVert] := 0;
    Dist[currVert] := 0;
  end;

  // Начальная вершина
  front := 1;
  next := 1;
  Queue[next] := startVert;
  Visit[startVert] := 1;

  // Волновой алгоритм
  pathFound := False;
  while (front <= next) and (not pathFound) do
  begin
    currVert := Queue[front];
    for sosedVert := 1 to COUNT_VERT do
    begin
      if (Graph[currVert, sosedVert] = 1) and (Visit[sosedVert] = 0) then
      begin
        next += 1;
        Queue[next] := sosedVert;
        Visit[sosedVert] := 1;
        Dist[sosedVert] := Dist[currVert] + 1;
        if sosedVert = finishVert then
        begin
          pathFound := True;
          Break;
        end;
      end;
    end;
    front += 1;
  end;

  // Восстановление пути
  if pathFound then
  begin
    pathLength := Dist[finishVert] + 1;
    Path[pathLength] := finishVert;
    currVert := finishVert;
    for var i := pathLength - 1 downto 1 do
    begin
      for sosedVert := 1 to COUNT_VERT do
      begin
        if (Graph[currVert, sosedVert] = 1) and (Dist[sosedVert] = i - 1) then
        begin
          Path[i] := sosedVert;
          currVert := sosedVert;
          Break;
        end;
      end;
    end;

    // Вывод пути
    Write('Путь: ');
    for var i := 1 to pathLength do
    begin
      Write(Path[i]);
      if i < pathLength then
        Write(' -> ');
    end;
    WriteLn;
    WriteLn('Расстояние: ', Dist[finishVert]);    
  end
  else
  begin
    WriteLn('Путь не найден');
  end;
end;

begin
  InitGraph(Graph);
  AddEdge(Graph, 1, 2);
  AddEdge(Graph, 1, 3);
  AddEdge(Graph, 2, 4);
  AddEdge(Graph, 3, 4);
  AddEdge(Graph, 4, 5);

  PrintMatrix(Graph);
  WaveAlgorithm(Graph, 1, 5);
end.
