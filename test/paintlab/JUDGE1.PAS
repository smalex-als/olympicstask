{
Written by Fyodor Menshikov 05.01.2004
14:08-14:18
}
{$R+,Q+,S+}
const
   _33=33;
var
   a:array[0.._33+1,0.._33+1]of char;

   procedure paint(i,j:integer);
   begin
      if a[i,j]<>'.' then
         exit;
      a[i,j]:='$';
      paint(i+1,j);
      paint(i-1,j);
      paint(i,j+1);
      paint(i,j-1);
   end;

var
   n,i,j:integer;
   count:integer;
begin
   assign(input,'paintlab.in');
   reset(input);
   assign(output,'paintlab.out');
   rewrite(output);
   readln(n);
   for i:=0 to _33+1 do
      for j:=0 to _33+1 do
         a[i,j]:='#';
   for i:=1 to n do begin
      for j:=1 to n do
         read(a[i,j]);
      readln;
   end;
   paint(1,1);
   paint(n,n);
   count:=0;
   for i:=1 to _33 do
      for j:=1 to _33 do
         if a[i,j]='$' then begin
            if a[i+1,j]='#' then
               inc(count);
            if a[i-1,j]='#' then
               inc(count);
            if a[i,j+1]='#' then
               inc(count);
            if a[i,j-1]='#' then
               inc(count);
         end;
    writeln((count-4)*9);
end.