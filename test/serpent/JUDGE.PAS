{
Written by Fyodor Menshikov 15.12.2003
14:34-14:42
}
var
   n,i,j,sum,cur:integer;
   a:array[1..100,1..100]of integer;
begin
   assign(input,'serpent.in');
   reset(input);
   assign(output,'serpent.out');
   rewrite(output);
   readln(n);
   cur:=0;
   sum:=1;
   while true do begin
      inc(sum);
      for i:=n downto 1 do
         for j:=n downto 1 do
            if i+j=sum then begin
               inc(cur);
               a[i,j]:=cur;
            end;
      if cur=n*n then
         break;
      inc(sum);
      for i:=1 to n do
         for j:=1 to n do
            if i+j=sum then begin
               inc(cur);
               a[i,j]:=cur;
            end;
      if cur=n*n then
         break;
   end;
   for i:=1 to n do begin
      for j:=1 to n do
         write(a[i,j]:6);
      writeln;
   end;
end.