{
Written by Fyodor Menshikov 28.03.2002
18:07-18:18
}
var
   a:array[0..101,0..101]of integer;
   n:integer;
   i,j:integer;
   di,dj:integer;
   cnt:integer;
begin
   assign(input,'spiral.in');
   reset(input);
   readln(n);
   close(input);
   for i:=0 to n+1 do
      for j:=0 to n+1 do
         a[i,j]:=1;
   for i:=1 to n do
      for j:=1 to n do
         a[i,j]:=0;
   i:=1;
   j:=0;
   di:=0;
   dj:=1;
   for cnt:=1 to n*n do begin
      if a[i+di,j+dj]<>0 then begin
         if (di=0)and(dj=1) then begin
            di:=1;
            dj:=0;
         end
         else if (di=1)and(dj=0) then begin
            di:=0;
            dj:=-1;
         end
         else if (di=0)and(dj=-1) then begin
            di:=-1;
            dj:=0;
         end
         else if (di=-1)and(dj=0) then begin
            di:=0;
            dj:=1;
         end
         else
            halt(1);
      end;
      inc(i,di);
      inc(j,dj);
      a[i,j]:=cnt;
   end;
   assign(output,'spiral.out');
   rewrite(output);
   for i:=1 to n do begin
      for j:=1 to n do
         write(a[i,j]:6);
      writeln;
   end;
   close(output);
end.