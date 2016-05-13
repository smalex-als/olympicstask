{
Written by Fyodor Menshikov 19.04.2002
14:17-14:26, debugged by 14:46
Modified into checker 22.12.2003
}
   procedure ac;
   begin
      writeln('a');
      halt(0);
   end;

   procedure wa;
   begin
      writeln('wa');
      halt(1);
   end;

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

   procedure check(judgeanswer:integer);
   var
      useranswer:integer;
   begin
      assign(input,'gangster.out');
      reset(input);
      if seekeof then
         pe;
      {$I-}
      readln(useranswer);
      {$I+}
      if ioresult<>0 then
         pe;
      if not eof then
         pe;
      if useranswer<>judgeanswer then
         wa;
      ac;
   end;

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
   check(cur[1]);
end.