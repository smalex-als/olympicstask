{
Written by Fyodor Menshikov 06.05.2002
11:14-11:30
I/O filename changed 12.01.2005
}
const
   wall=-1;
   empty=-2;
   way=-3;
var
   a:array[0..41,0..41]of integer;
   i,j,k,n,ti,tj:integer;
   c:char;
begin
   assign(input,'lines.in');
   reset(input);
   readln(n);
   for i:=0 to n+1 do
      for j:=0 to n+1 do
         a[i,j]:=wall;
   for i:=1 to n do begin
      for j:=1 to n do begin
         read(c);
         case c of
         'O':a[i,j]:=wall;
         '.':a[i,j]:=empty;
         '@':a[i,j]:=1;
         'X':begin
            a[i,j]:=empty;
            ti:=i;
            tj:=j;
         end;
         else
            halt(1);
         end;
      end;
      readln;
   end;
   for k:=1 to n*n do begin
      for i:=1 to n do
         for j:=1 to n do
            if a[i,j]=k then begin
               if a[i+1,j]=empty then
                  a[i+1,j]:=k+1;
               if a[i-1,j]=empty then
                  a[i-1,j]:=k+1;
               if a[i,j+1]=empty then
                  a[i,j+1]:=k+1;
               if a[i,j-1]=empty then
                  a[i,j-1]:=k+1;
            end;
   end;
   assign(output,'lines.out');
   rewrite(output);
   if a[ti,tj]=empty then begin
      writeln('N');
      halt;
   end;
   while a[ti,tj]<>1 do begin
      if a[ti-1,tj]=a[ti,tj]-1 then begin
         a[ti,tj]:=way;
         ti:=ti-1;
      end
      else if a[ti+1,tj]=a[ti,tj]-1 then begin
         a[ti,tj]:=way;
         ti:=ti+1;
      end
      else if a[ti,tj-1]=a[ti,tj]-1 then begin
         a[ti,tj]:=way;
         tj:=tj-1;
      end
      else if a[ti,tj+1]=a[ti,tj]-1 then begin
         a[ti,tj]:=way;
         tj:=tj+1;
      end
      else
         halt(2);
   end;
   writeln('Y');
   for i:=1 to n do begin
      for j:=1 to n do begin
         case a[i,j] of
         wall:write('O');
         1:write('@');
         way:write('+');
         else
            write('.');
         end;
      end;
      writeln;
   end;
end.