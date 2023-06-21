{В СВ дереве найти расположение(высоту) элемента в дереве и его расположение среди братьев}

program MyLibrary;


type
  PItem = ^Item;
  Item = record
    folder : string; 
    bro : PItem; 
    child : PItem; 
  end;



procedure CreateNode(var Tree : PItem; folder : string);
  begin
    new(Tree);
    Tree^.folder := folder;
    Tree^.bro := nil;
    Tree^.child := nil;
  end;


procedure FindFolder(Tree : PItem; folder : string; var ResultItem : PItem);
  begin
    ResultItem := nil;
    if Tree <> nil then
      if Tree^.folder = folder then 
        ResultItem := Tree
      else
        begin
          FindFolder(Tree^.bro, folder, ResultItem);
          if ResultItem = nil then 
            FindFolder(Tree^.child, folder, ResultItem);
        end;
  end;

procedure AddSubFolder(var Tree: PItem; folder : string; subFolder: string);
  var 
    Fold : PItem;
  begin
    if Tree <> nil then
      begin
        FindFolder(Tree, folder, Fold);
        if Fold <> nil then
          if Fold^.child = nil then
            CreateNode(Fold^.child, subFolder)
          else
            begin
              Fold := Fold^.child;
              while Fold^.bro <> nil do
                Fold := Fold^.bro;
              CreateNode(Fold^.bro, subFolder);
            end;
      end;
  end;

procedure PrintTree(tree : PItem; indent : integer); 
  begin
     if Tree <> nil then
       begin
         writeln(' ' * indent ,tree^.folder);  
         PrintTree(tree^.child, indent + 2);
         PrintTree(tree^.bro, indent);
       end;
  end;

procedure DeleteTree(var tree : PItem);
  begin
     if Tree <> nil then
       begin
         DeleteTree(tree^.child);
         DeleteTree(tree^.bro);
         dispose(tree);
         tree := nil;
       end;
  end;


procedure FindDepPos(Tree: PItem; folder: string; var Depth, Position: integer);
var
  CurrentItem: PItem;
  LevelPosition: integer;
begin
  Depth := 0;
  Position := 0;
  LevelPosition := 1;
  CurrentItem := Tree; 
  while CurrentItem <> nil do
    begin
      if CurrentItem^.folder = folder then
        begin
          Depth := Depth + 1;
          Position := LevelPosition;
          Exit;
        end;
      if CurrentItem^.child <> nil then
        begin
          FindDepPos(CurrentItem^.child, folder, Depth, Position);
          if Depth > 0 then
            begin
              Depth := Depth + 1;
              Exit;
            end;
        end;
      CurrentItem := CurrentItem^.bro;
      LevelPosition := LevelPosition + 1;
    end;
end;



procedure DeleteItemWithChildren(var Tree: PItem; folder: string);
var
  CurrentItem: PItem;
  PrevItem: PItem;
begin
  CurrentItem := Tree;
  PrevItem := nil;

  while CurrentItem <> nil do
  begin
    if CurrentItem^.folder = folder then
    begin
      if PrevItem <> nil then
        PrevItem^.bro := CurrentItem^.bro
      else
        Tree := CurrentItem^.bro;

      DeleteTree(CurrentItem^.child);
      dispose(CurrentItem);
      Exit;
    end;

    PrevItem := CurrentItem;
    CurrentItem := CurrentItem^.bro;
  end;

  CurrentItem := Tree;

  while CurrentItem <> nil do
  begin
    DeleteItemWithChildren(CurrentItem^.child, folder);
    CurrentItem := CurrentItem^.bro;
  end;
end;

var
  Tree: PItem;
  Depth: integer;
  Position: integer;
  name : string;
begin
  CreateNode(Tree, 'ROOT');
  AddSubFolder(Tree, 'ROOT', 'Жанр');
  AddSubFolder(Tree, 'Жанр', 'Антиутопия');
  AddSubFolder(Tree, 'Жанр', 'Трагедия');
  AddSubFolder(Tree, 'Жанр', 'Роман');
  AddSubFolder(Tree, 'Антиутопия', 'Платонов');
  AddSubFolder(Tree, 'Антиутопия', 'Оруэлл');
  AddSubFolder(Tree, 'Трагедия', 'Гёте');
  AddSubFolder(Tree, 'Роман', 'Паланик');
  AddSubFolder(Tree, 'Оруэлл', '1984');
  AddSubFolder(Tree, 'Оруэлл', 'Скотный двор');
  AddSubFolder(Tree, 'Платонов', 'Котлован');
  AddSubFolder(Tree, 'Гёте', 'Фауст');
  AddSubFolder(Tree, 'Паланик', 'Бойцовский клуб');
  PrintTree(Tree,2);
  write('Информацию о какой папке вы желаете найти? Введите имя: ');
  readln(name);
  FindDepPos(Tree, name, Depth, Position);
  writeln('Номер уровня, элемента "' + name + '": ' + Depth);
  writeln('Номер позиции на уровне, элемента "' + name + '": ' + Position);
  DeleteItemWithChildren(Tree, '1984');
  PrintTree(Tree,2);
  DeleteTree(Tree);
end.