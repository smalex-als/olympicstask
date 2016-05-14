{
Written by Fyodor Menshikov 27.02.2004
PE: not numbers, not m<=i1<i2<=n, not increasing i1
WA: not friendly, something skipped
}
{$I+,R+,Q+}

   procedure ac;
   begin
      writeln('a');
      halt;
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

const
   correct:array[1..40,1..2]of longint=(
      (220,284),
      (1184,1210),
      (2620,2924),
      (5020,5564),
      (6232,6368),
      (10744,10856),
      (12285,14595),
      (17296,18416),
      (63020,76084),
      (66928,66992),
      (67095,71145),
      (69615,87633),
      (79750,88730),
      (100485,124155),
      (122265,139815),
      (122368,123152),
      (141664,153176),
      (142310,168730),
      (171856,176336),
      (176272,180848),
      (185368,203432),
      (196724,202444),
      (280540,365084),
      (308620,389924),
      (319550,430402),
      (356408,399592),
      (437456,455344),
      (469028,486178),
      (503056,514736),
      (522405,525915),
      (600392,669688),
      (609928,686072),
      (624184,691256),
      (635624,712216),
      (643336,652664),
      (667964,783556),
      (726104,796696),
      (802725,863835),
      (879712,901424),
      (898216,980984));
var
   c:char;

   procedure nextchar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
   end;

   procedure checkspace;
   begin
      if c<>' ' then
         pe;
      nextchar;
   end;

   procedure checkeoln;
   begin
      if c<>#13 then
         pe;
      readln;
   end;

   procedure checknum;
   begin
      if c='0' then begin
         nextchar;
      end
      else if c in ['1'..'9'] then begin
         nextchar;
         while c in ['0'..'9'] do
            nextchar;
      end
      else
         pe;
   end;

var
   m,n,i,judgecount,usercount,i1,i2,i1prev:longint;
   s:string;
   found:boolean;
begin
   assign(input,'friendly.in');
   reset(input);
   readln(m,n);
   judgecount:=0;
   for i:=low(correct) to high(correct) do
      if (m<=correct[i,1]) and (correct[i,2]<=n) then
         inc(judgecount);
   assign(input,'friendly.out');
   reset(input);
   readln(s);
   if s='Absent' then begin
      if not eof then
         pe;
      if judgecount<>0 then
         wa;
      ac;
   end;
   if s='' then{first line empty - pe}
      pe;
   {checking format: 2 integers one space separated}
   reset(input);
   while not eof do begin
      nextchar;
      checknum;
      checkspace;
      checknum;
      checkeoln;
   end;
   {checking longint range - if greater than maxlongint then greater than N}
   reset(input);
   while not eof do begin
      {$I-}
      read(i);
      {$I+}
      if ioresult<>0 then
         pe;
      {$I-}
      readln(i);
      {$I+}
      if ioresult<>0 then
         pe;
   end;
   {checking M<=i1<i2<=N}
   reset(input);
   while not eof do begin
      readln(i1,i2);
      if m>i1 then
         pe;
      if i1>=i2 then
         pe;
      if i2>n then
         pe;
   end;
   {checking i1>i1prev}
   reset(input);
   readln(i1prev);
   while not eof do begin
      readln(i1);
      if i1<=i1prev then
         pe;
      i1prev:=i1;
   end;
   {checking that user numbers are really friendly}
   reset(input);
   while not eof do begin
      readln(i1,i2);
      found:=false;
      for i:=low(correct) to high(correct) do
         if (i1=correct[i,1]) and (i2=correct[i,2]) then
            found:=true;
      if not found then
         wa;
   end;
   {checking number of user pairs}
   reset(input);
   usercount:=0;
   while not eof do begin
      readln;
      inc(usercount);
   end;
   if usercount<>judgecount then
      wa;
   ac;
end.