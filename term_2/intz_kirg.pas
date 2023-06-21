function BuildKirchhoffMatrix(adjacencyMatrix: array of array of Integer): array of array of Integer;
var
  n, i, j, degree: Integer;
  kirchhoffMatrix: array of array of Integer;
begin
  n := Length(adjacencyMatrix);
  SetLength(kirchhoffMatrix, n, n);

  // Заполнение матрицы Кирхгофа
  for i := 0 to n - 1 do
  begin
    degree := 0;
    for j := 0 to n - 1 do
    begin
      if i = j then
        kirchhoffMatrix[i, j] := 0
      else if adjacencyMatrix[i, j] = 1 then
      begin
        kirchhoffMatrix[i, j] := -1;
        Inc(degree);
      end
      else
        kirchhoffMatrix[i, j] := 0;
    end;
    kirchhoffMatrix[i, i] := degree;
  end;

  Result := kirchhoffMatrix;
end;




function BuildIncidenceMatrix(adjacencyMatrix: array of array of Integer): array of array of Integer;
var
  n, m, i, j, edgeCount: Integer;
  incidenceMatrix: array of array of Integer;
begin
  n := Length(adjacencyMatrix);
  m := 0; // Количество ребер
  for i := 0 to n - 1 do
    for j := i + 1 to n - 1 do
      if adjacencyMatrix[i, j] = 1 then
        Inc(m);

  SetLength(incidenceMatrix, n, m);
  edgeCount := 0;

  // Заполнение матрицы инцидентности
  for i := 0 to n - 1 do
  begin
    for j := i + 1 to n - 1 do
    begin
      if adjacencyMatrix[i, j] = 1 then
      begin
        incidenceMatrix[i, edgeCount] := 1;
        incidenceMatrix[j, edgeCount] := 1;
        Inc(edgeCount);
      end;
    end;
  end;

  Result := incidenceMatrix;
end;
