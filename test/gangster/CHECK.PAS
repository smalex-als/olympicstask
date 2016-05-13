{
Written by Fyodor Menshikov 26.12.2003
21:11-21:21
Modified into checker 26.12.2003
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

var
   n,k,t:integer;
   g:array[0..100]of record
      t,p,s,sump:integer;
   end;
   i,j,max:integer;
begin
   assign(input,'gangster.in');
   reset(input);
   readln(n,k,t);
   for i:=1 to n do
      read(g[i].t);
   readln;
   for i:=1 to n do
      read(g[i].p);
   readln;
   for i:=1 to n do
      read(g[i].s);
   readln;
   j:=0;
   for i:=1 to n do
      if g[i].t>=g[i].s then begin
         inc(j);
         g[j]:=g[i];
      end;
   n:=j;
   for i:=1 to n do
      for j:=1 to n do
         if (i<=j)and(g[i].t>g[j].t) then begin
            g[0]:=g[i];
            g[i]:=g[j];
            g[j]:=g[0];
         end;
   for i:=1 to n do begin
      g[i].sump:=g[i].p;{only}
      for j:=1 to i-1 do
         if abs(g[j].s-g[i].s)<=g[i].t-g[j].t then
            if g[j].sump+g[i].p>g[i].sump then
               g[i].sump:=g[j].sump+g[i].p;
   end;
   max:=0;
   for i:=1 to n do
      if g[i].sump>max then
         max:=g[i].sump;
   check(max);
end.