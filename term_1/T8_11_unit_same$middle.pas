program student_height_unit;

uses
  UnitForSameMiddle;

var student : StudentGroup;
  fileName : string;
begin
  fileName := 'd:\code_file\PABC\students.dat';
  addStudent(fileName);
  listStudents(fileName);
  HighestWoman(fileName);
  SameHaS(fileName);
end.
