{
Written by Fyodor Menshikov 26.12.2003
21:11-21:21
}
var
   n,k,t:integer;
   g:array[0..100]of record
      t,p,s,sump:integer;
   end;
   i,j,max:integer;
begin
   assign(input,'gangster.in');
   reset(input);
   assign(output,'gangster.out');
   rewrite(output);
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
   writeln(max);
end.