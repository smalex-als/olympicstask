{
Written by Fyodor Menshikov 14.03.2002
22:23-22:33
1..15000 4s
Q+,R+ 1..15000 87s
I/O filename changed 12.01.2005
}
{$Q-,R-}
var
   x:array[1..15000]of word;
   len:array[1..15000]of integer;
   n:integer;
   i,j,max,pos:integer;
begin
   assign(input,'incseq.in');
   reset(input);
   readln(n);
   for i:=1 to n do begin
      read(x[i]);
      {writeln(i);}
      max:=0;
      for j:=1 to i-1 do begin
         if (x[j]<x[i])and(len[j]>max) then
            max:=len[j];
      end;
      len[i]:=max+1;
   end;
   close(input);
   max:=0;
   for i:=1 to n do
      if len[i]>max then begin
         max:=len[i];
         pos:=i;
      end;
   n:=pos;
   for i:=n-1 downto 1 do begin
      if (x[i]<x[pos])and(len[i]=len[pos]-1) then
         pos:=i
      else
         len[i]:=0;
   end;
   assign(output,'incseq.out');
   rewrite(output);
   writeln(len[n]);
   for i:=1 to n do
      if len[i]<>0 then
         write(x[i],' ');
   writeln;
   close(output);
end.