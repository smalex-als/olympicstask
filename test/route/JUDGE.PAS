{
Written by Fyodor Menshikov 28.03.2002
17:35-17:50
I/O filename changed 12.01.2005
}
type
   tdirect=array[1..250,1..250]of (from_up,from_left,stop);
   tdigit=array[1..250,1..250]of byte;
   tway=array[1..250,1..250]of char;
var
   direct:^tdirect;
   digits:^tdigit;
   way:^tway;
   n,i,j:integer;
   c:char;
   sum1,sum2:array[1..250]of integer;
   s:integer;
begin
   new(direct);
   new(digits);
   new(way);
   assign(input,'route.in');
   reset(input);
   readln(n);
   for i:=1 to n do begin
      for j:=1 to n do begin
         read(c);
         digits^[i,j]:=ord(c)-ord('0');
      end;
      readln;
   end;
   close(input);
   direct^[1,1]:=stop;
   sum1[1]:=digits^[1,1];
   for j:=2 to n do begin
      sum1[j]:=sum1[j-1]+digits^[1,j];
      direct^[1,j]:=from_left;
   end;
   for i:=2 to n do begin
      direct^[i,1]:=from_up;
      sum2[1]:=sum1[1]+digits^[i,1];
      for j:=2 to n do begin
         if sum1[j]<sum2[j-1] then begin
            sum2[j]:=sum1[j]+digits^[i,j];
            direct^[i,j]:=from_up;
         end
         else begin
            sum2[j]:=sum2[j-1]+digits^[i,j];
            direct^[i,j]:=from_left;
         end;
      end;
      sum1:=sum2;
   end;
   for i:=1 to n do begin
      for j:=1 to n do begin
         way^[i,j]:='-';
      end;
   end;
   i:=n;
   j:=n;
   while true do begin
      way^[i,j]:='#';
      if direct^[i,j]=stop then
         break
      else if direct^[i,j]=from_up then
         i:=i-1
      else if direct^[i,j]=from_left then
         j:=j-1;
   end;
   assign(output,'route.out');
   rewrite(output);
   for i:=1 to n do begin
      for j:=1 to n do
         write(way^[i,j]);
      writeln;
   end;
   close(output);
end.