{
Written by Fyodor Menshikov 17.05.2002
12:46-13:20+tests
Процедура Паскаля сохраняет BP, даже если нет локальных переменных
I/O file name changed 05.01.2004
}
{$M 65520,0,0}
var
   n,x,y:integer;
   lab:array[0..101,0..101]of char;

   procedure paint;
   begin
      if lab[x,y]<>'.' then
         exit;
      lab[x,y]:='$';

      x:=x+1;
      paint;
      x:=x-1;

      x:=x-1;
      paint;
      x:=x+1;

      y:=y+1;
      paint;
      y:=y-1;

      y:=y-1;
      paint;
      y:=y+1;
   end;

var
   cnt:longint;
begin
   assign(input,'paintlab.in');
   reset(input);
   readln(n);
   for x:=0 to n+1 do
      for y:=0 to n+1 do
         lab[x,y]:='#';
   for x:=1 to n do begin
      for y:=1 to n do
         read(lab[x,y]);
      readln;
   end;
   x:=1;
   y:=1;
   paint;
   x:=n;
   y:=n;
   paint;
   cnt:=0;
   for x:=1 to n do
      for y:=1 to n do
         if lab[x,y]='$' then begin
            if lab[x+1,y]='#' then
               inc(cnt);
            if lab[x-1,y]='#' then
               inc(cnt);
            if lab[x,y+1]='#' then
               inc(cnt);
            if lab[x,y-1]='#' then
               inc(cnt);
         end;
   cnt:=cnt-4;
   assign(output,'paintlab.out');
   rewrite(output);
   writeln(cnt*9);
end.