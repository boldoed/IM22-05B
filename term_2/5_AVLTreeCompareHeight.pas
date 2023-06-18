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


procedure CompareHeight(root : Tree);
  begin
     if root <> nil then
  begin
    CompareHeight(root^.Right);
    if root^.left <> nil then
      begin
        if root^.right <> nil then
          begin
            if root^.left^.height = root^.right^.height then
              begin
                write(root^.Data, ' ');  
              end;
            CompareHeight(root^.Left);
          end;
      end;
  end;
end;



var
  root: Tree;
begin
  root := nil;

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

  PrintTree(root, 0);
  writeln;
  write('Значения узлов с равными глубинами левого и прового поддерева: ');
  CompareHeight(root);
end.
