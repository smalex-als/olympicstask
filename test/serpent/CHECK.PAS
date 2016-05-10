{
Written by Fyodor Menshikov 28.03.2002
18:07-18:18
Check 15.12.2002 7:31-7:40
Modified from spiral to serpent 15.12.2003
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

var
   a:array[1..100,1..100]of integer;
   i,j,n:integer;
   sum,cur:integer;
   long:longint;
   _wa:boolean;
begin
   assign(input,'serpent.in');
   reset(input);
   readln(n);
   cur:=0;
   sum:=1;
   while true do begin
      inc(sum);
      for i:=n downto 1 do
         for j:=n downto 1 do
            if i+j=sum then begin
               inc(cur);
               a[i,j]:=cur;
            end;
      if cur=n*n then
         break;
      inc(sum);
      for i:=1 to n do
         for j:=1 to n do
            if i+j=sum then begin
               inc(cur);
               a[i,j]:=cur;
            end;
      if cur=n*n then
         break;
   end;
   assign(input,'serpent.out');
   reset(input);
   _wa:=false;
   for i:=1 to n do begin
      for j:=1 to n do begin
         if seekeoln then
            pe;
         {$I-}
         read(long);
         {$I+}
         if ioresult<>0 then
            pe;
         if (long<=0)or(long>n*n) then
            pe;
         if long<>a[i,j] then
            _wa:=true;
      end;
      if not seekeoln then
         pe;
      readln;
   end;
   if not eof then
      pe;
   if _wa then
      wa;
   ac;
end.