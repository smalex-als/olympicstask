{
Written by Fyodor Menshikov 19.04.2002
14:17-14:26, debugged by 14:46
}

   function max3(x,y,z:integer):integer;
   begin
      if y>x then
         x:=y;
      if z>x then
         x:=z;
      max3:=x;
   end;

var
   n,k,tt:integer;
   i,j:integer;
   prev,cur,sum:array[-1..101]of integer;
   tmp:integer;
   t,p,s:array[1..100]of integer;
begin
   assign(input,'gangster.in');
   reset(input);
   readln(n,k,tt);
   for i:=1 to n do
      read(t[i]);
   for i:=1 to n do
      read(p[i]);
   for i:=1 to n do
      read(s[i]);
   close(input);
   j:=0;
   for i:=1 to n do begin
      if t[i]>=s[i] then begin
         inc(j);
         t[j]:=t[i];
         p[j]:=p[i];
         s[j]:=s[i];
      end;
   end;
   n:=j;
   for i:=-1 to k+1 do
      cur[i]:=0;
   for tt:=1 to 30200 do begin
      prev:=cur;
      for i:=-1 to k+1 do
         sum[i]:=0;
      for i:=1 to n do
         if t[i]=tt then
            inc(sum[s[i]],p[i]);
      for i:=1 to k do
         cur[i]:=sum[i]+max3(prev[i-1],prev[i],prev[i+1]);
   end;
   assign(output,'gangster.out');
   rewrite(output);
   writeln(cur[1]);
   close(output);
end.