{
Written by Fyodor Menshikov 04.01.2003
10:34-10:40
Modified into checker 15.12.2003
}
{$N+,E-}
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

type
   charcomp=record
   case integer of
      0:(key:comp);
      1:(c:array[1..8]of char);
   end;
   a5040=array[0..5039]of charcomp;
var
   da:array[0..7]of ^a5040;

   procedure createarray;
   var
      i:integer;
   begin
      for i:=0 to 7 do
         new(da[i]);
   end;

   procedure put(index:longint;c:comp);
   begin
      da[index div 5040]^[index mod 5040].key:=c;
   end;

   function get(index:longint):comp;
   begin
      get:=da[index div 5040]^[index mod 5040].key;
   end;

   procedure puts(index:longint;var value:string);
   var
      t:charcomp;
      i:integer;
   begin
      t.key:=0;
      for i:=1 to length(value) do
         t.c[i]:=value[i];
      put(index,t.key);
   end;

   procedure show(index:longint);
   var
      i:integer;
      t:charcomp;
   begin
      t.key:=get(index);
      for i:=8 downto 1 do
         if t.c[i]<>#0 then
            write(t.c[i]);
      writeln;
   end;

   procedure sort(l,r:longint);
   var
      i,j:longint;
      key:comp;
      buf:comp;
   begin
      key:=get((l+r)div 2);
      i:=l;
      j:=r;
      repeat
         while get(i)<key do
            inc(i);
         while key<get(j) do
            dec(j);
         if i<=j then begin
            buf:=get(i);
            put(i,get(j));
            put(j,buf);
            inc(i);
            dec(j);
         end;
      until i>j;
      if l<j then
         sort(l,j);
      if i<r then
         sort(i,r);
   end;

var
   s,su:string;
   a,au:array[char]of byte;
   linecnt,linecntu,li:longint;

   procedure rec(step:integer);
   var
      c:char;
   begin
      if step=length(s)+1 then
         inc(linecnt)
      else begin
         for c:=#0 to #255 do
            if a[c]>0 then begin
               dec(a[c]);
               s[step]:=c;
               rec(step+1);
               inc(a[c]);
            end;
      end;
   end;

var
   i:integer;
   c:char;
begin
   assign(input,'permut2.in');
   reset(input);
   for c:=#0 to #255 do
      a[c]:=0;
   readln(s);
   for i:=1 to length(s) do
      inc(a[s[i]]);
   linecnt:=0;
   rec(1);
   assign(input,'permut2.out');
   reset(input);
   linecntu:=0;
   while not eof do begin
      readln(su);
      inc(linecntu);
      if length(su)<>length(s) then{wrong line length}
         pe;
      for c:=#0 to #255 do
         au[c]:=0;
      for i:=1 to length(su) do
         inc(au[su[i]]);
      for c:=#0 to #255 do
         if au[c]<>a[c] then{wrong symbols set in line}
            pe;
   end;
   if linecntu<>linecnt then
      wa;{either double line or something is missing}
   {checking that all different}
   reset(input);
   createarray;
   linecntu:=0;
   while not eof do begin
      readln(su);
      puts(linecntu,su);
      inc(linecntu);
   end;
   sort(0,linecntu-1);
   for li:=1 to linecntu-1 do
      if get(li-1)=get(li) then
         wa;
   {for li:=0 to linecntu-1 do
      show(li);}
   ac;
end.