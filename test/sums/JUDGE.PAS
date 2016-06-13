{
Written by Fyodor Menshikov 29.07.2002
8:18-8:24
I/O filename changed 12.01.2005
}
{$R-}
var
   b:array[0..50000]of boolean;
   i,n:integer;
   a,j,max,s:word;
begin
   assign(input,'sums.in');
   reset(input);
   readln(n);
   for j:=0 to 50000 do
      b[j]:=false;
   b[0]:=true;
   max:=0;
   for i:=1 to n do begin
      read(a);
      for j:=max downto 0 do
         if b[j] then
            b[j+a]:=true;
      inc(max,a);
   end;
   s:=0;
   for j:=0 to max do
      if b[j] then
         inc(s);
   assign(output,'sums.out');
   rewrite(output);
   writeln(s);
end.