{
Written by Fyodor Menshikov 28.03.2002
18:07-18:18
Check 15.12.2002 7:31-7:40
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
   a:array[0..101,0..101]of integer;
   n:integer;
   i,j:integer;
   di,dj:integer;
   cnt:integer;
   long:longint;
   _wa:boolean;
begin
   assign(input,'spiral.in');
   reset(input);
   readln(n);
   for i:=0 to n+1 do
      for j:=0 to n+1 do
         a[i,j]:=1;
   for i:=1 to n do
      for j:=1 to n do
         a[i,j]:=0;
   i:=1;
   j:=0;
   di:=0;
   dj:=1;
   for cnt:=1 to n*n do begin
      if a[i+di,j+dj]<>0 then begin
         if (di=0)and(dj=1) then begin
            di:=1;
            dj:=0;
         end
         else if (di=1)and(dj=0) then begin
            di:=0;
            dj:=-1;
         end
         else if (di=0)and(dj=-1) then begin
            di:=-1;
            dj:=0;
         end
         else if (di=-1)and(dj=0) then begin
            di:=0;
            dj:=1;
         end
         else
            halt(1);
      end;
      inc(i,di);
      inc(j,dj);
      a[i,j]:=cnt;
   end;
   assign(input,'spiral.out');
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