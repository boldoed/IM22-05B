program MinPathTree;

type
  Tree = ^Node;
  Node = record
    Data: Integer;
    Left: ^Node;
    Right: ^Node;
  end;
  

procedure InsertNode(var root: Tree; data: Integer);
begin
  if root = nil then
  begin
    New(root);
    root^.Data := data;
    root^.Left := nil;
    root^.Right := nil;
  end
  else if data < root^.Data then
    InsertNode(root^.Left, data)
  else
    InsertNode(root^.Right, data);
end;

procedure PrintTree(root: Tree; level: Integer);
    begin
        if (root <> nil) then
        begin
            PrintTree(root^.right, level + 4);
              writeln(' '*level, root^.data);
            PrintTree(root^.left, level + 4);
        end; 
    end;

function FindMinPath(root: Tree): String;
var
  leftPath, rightPath: String;
begin
  if root = nil then
    Result := ''
  else if (root^.Left = nil) and (root^.Right = nil) then
    Result := IntToStr(root^.Data)
  else
  begin
    leftPath := FindMinPath(root^.Left);
    rightPath := FindMinPath(root^.Right);

    if (leftPath = '') or (Length(leftPath) > Length(rightPath)) then
      Result := IntToStr(root^.Data) + ' -> ' + rightPath
    else
      Result := IntToStr(root^.Data) + ' -> ' + leftPath;
  end;
end;

var
  root: Tree;
  minPath: String;
begin
  root := nil;

  // Вставляем узлы в дерево
  InsertNode(root, 8);
  InsertNode(root, 3);
  InsertNode(root, 10);
  InsertNode(root, 1);
  InsertNode(root, 6);
  InsertNode(root, 14);
  InsertNode(root, 4);
  InsertNode(root, 7);
  InsertNode(root, 13);
  InsertNode(root, 2);

  PrintTree(root, 0);

  minPath := FindMinPath(root);
  WriteLn('Минимальный путь: ', minPath);

end.
