{
Written by Fyodor Menshikov 19.01.2003
10:34-10:44
}
var
   n,k,i,j:integer;
   a:array[1..100,1..100]of integer;
   sum:array[0..101,0..101]of longint;
   max:longint;
begin
   assign(input,'route2.in');
   reset(input);
   assign(output,'route2.out');
   rewrite(output);
   readln(n,k);
   for i:=1 to n do begin
      for j:=1 to n do
         read(a[i,j]);
      readln;
   end;
   for i:=0 to n+1 do
      for j:=0 to n+1 do
         sum[i,j]:=0;
   sum[1,1]:=a[1,1];
   for k:=2 to k do begin
      for i:=1 to n do
         for j:=1 to n do
            if odd(i+j)<>odd(k) then begin
               max:=0;
               if sum[i+1,j]>max then
                  max:=sum[i+1,j];
               if sum[i-1,j]>max then
                  max:=sum[i-1,j];
               if sum[i,j-1]>max then
                  max:=sum[i,j-1];
               if sum[i,j+1]>max then
                  max:=sum[i,j+1];
               if max=0 then
                  sum[i,j]:=0
               else
                  sum[i,j]:=max+a[i,j];
            end;
   end;
   max:=0;
   for i:=1 to n do
      for j:=1 to n do
         if sum[i,j]>max then
            max:=sum[i,j];
   writeln(max);
end.