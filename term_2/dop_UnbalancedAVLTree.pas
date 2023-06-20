program AVLTreeCompareHeight;

type
  Tree = ^Roots;
  Roots = record
    Data: Integer;
    Left: Tree;
    Right: Tree;
    Height: Integer;
  end;


function GetHeight(root: Tree): Integer;
  begin
    if root = nil then
      Result := -1
    else
      Result := root^.Height;
  end;


procedure UpdateHeight(root: Tree);
  begin
    if root <> nil then
      root^.Height := Max(GetHeight(root^.Left), GetHeight(root^.Right)) + 1;
  end;


function BalanceFactor(root: Tree): Integer;
  begin
    if root = nil then
      Result := 0
    else
      Result := GetHeight(root^.Left) - GetHeight(root^.Right);
  end;


function RotateLeft(root: Tree): Tree;
  var
    pivot: Tree;
  begin
    pivot := root^.Right;
    root^.Right := pivot^.Left;
    pivot^.Left := root;
    UpdateHeight(root);
    UpdateHeight(pivot);
    Result := pivot;
  end;


function RotateRight(root: Tree): Tree;
  var
    pivot: Tree;
  begin
    pivot := root^.Left;
    root^.Left := pivot^.Right;
    pivot^.Right := root;
    UpdateHeight(root);
    UpdateHeight(pivot);
    Result := pivot;
  end;


function BalanceTree(root: Tree): Tree;
  begin
    UpdateHeight(root);
    if BalanceFactor(root) = 2 then
    begin
      if BalanceFactor(root^.Left) < 0 then
        root^.Left := RotateLeft(root^.Left);
      Result := RotateRight(root);
    end
    else if BalanceFactor(root) = -2 then
    begin
      if BalanceFactor(root^.Right) > 0 then
        root^.Right := RotateRight(root^.Right);
      Result := RotateLeft(root);
    end
    else
      Result := root;
  end;


procedure InsertNode(var root: Tree; data: Integer);
  begin
    if root = nil then
    begin
      New(root);
      root^.Data := data;
      root^.Left := nil;
      root^.Right := nil;
      root^.Height := 0;
    end
    else if data < root^.Data then
      InsertNode(root^.Left, data)
    else
      InsertNode(root^.Right, data);
  
    root := BalanceTree(root);
  end;


procedure PrintTree(root: Tree; level: Integer);
  begin
    if root <> nil then
    begin
      PrintTree(root^.Right, level + 4);
      writeln(' ' * level, root^.Data);
      PrintTree(root^.Left, level + 4);
    end;
  end;


function Depth(node: Tree): Integer;
begin
  if node = nil then
    Result := 0
  else
    Result := 1 + Max(Depth(node^.Left), Depth(node^.Right));
end;


function FindDeepestSide(root: Tree): integer;
var
  leftDepth, rightDepth: Integer;
begin
  leftDepth := Depth(root^.Left);
  rightDepth := Depth(root^.Right);

  if leftDepth > rightDepth then
    Result := -1
  else if rightDepth > leftDepth then
    Result := 1
  else
    Result := 0;
end;


procedure RotateTree(var root: Tree);
var
  deepestSide: Integer;
begin
  deepestSide := FindDeepestSide(root);

  if deepestSide = 1 then
    root := RotateLeft(root)
  else if deepestSide = -1 then
    root := RotateRight(root)
  else if deepestSide = 0 then
  begin
    root := RotateRight(root);
    root := RotateRight(root);
  end;
end;



var
  root: Tree;
  method, n, val : integer;
begin
  root := nil;
  writeln('Каким способом задать дерево? 1 - рандомно с n узлами. 2 - вручную. 3 - через код');
  readln(method);
  if method = 3 then
    begin
      InsertNode(root, 1);
      InsertNode(root, 2);
      InsertNode(root, 3);
      InsertNode(root, 4);
      InsertNode(root, 5);
      InsertNode(root, 6);
      InsertNode(root, 7);
      InsertNode(root, 8);
      InsertNode(root, 9);
      InsertNode(root, 10);
    end;
  if method = 1 then
    begin
      writeln('Введите сколько узлов будет в дереве: ');
      readln(n);
      for var i := 1 to n do
        InsertNode(root, random(1, 50));
    end;
  if method = 2 then
    begin
      while val <> -1 do
        begin
          writeln('Введите значение узла, если хотите закончить вводить, напишите -1');
          readln(val);
          InsertNode(root, val);
        end;
    end;
    
  writeln('Исходное АВЛ дерево: ');
  PrintTree(root, 0);
  writeln('----------------');
  writeln('Разбалансированное дерево (не сбалансированное): ');
  RotateTree(root);
  PrintTree(root, 0);
end.