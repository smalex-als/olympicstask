{
Written by Fyodor Menshikov 05.04.2002
Output format edited 15.12.2002
I/O filename changed 12.01.2005
}

   procedure a;
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
   checksum,newsum,sharp:integer;
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
   checksum:=sum1[n];
   assign(input,'route.out');
   reset(input);
   newsum:=0;
   sharp:=0;
   for i:=1 to n do begin
      for j:=1 to n do begin
         if eof then
            pe;
         if eoln then
            pe;
         read(c);
         if not (c in ['-','#']) then
            pe;
         if c='#' then begin
            inc(newsum,digits^[i,j]);
            inc(sharp);
         end;
      end;
      if not eoln then
         pe;
      readln;
   end;
   if not eof then
      pe;
   if sharp<>n*2-1 then
      pe;
   if newsum<>checksum then
      wa;
   a;
end.