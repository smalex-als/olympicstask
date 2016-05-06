{
Written by Fyodor Menshikov 04.09.2002
10:03-10:32
Modified for primes2 24.11.2002
7:35-8:18
}
{$N+,E-,R-,Q-,S-,I+}

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

   function isPrime(n:longint):boolean;
   var
      i:integer;
   begin
      isPrime:=false;
      for i:=2 to trunc(sqrt(n)) do
         if n mod i=0 then
            exit;
      isPrime:=true;
   end;

const
   maxP=305;{2011 is 305th prime}
var
   primes:array[0..maxP]of longint;

   procedure InitPrimeTable;
   var
      index,i:integer;
   begin
      index:=0;
      i:=2;
      while true do begin
         if isPrime(i) then begin
            inc(index);
            primes[index]:=i;
            if index=maxP then
               break;
         end;
         inc(i);
      end;
   end;

   procedure CheckPrime(i:longint);
   var
      ui:longint;
   begin
      if eof then
         wa;{not enough numbers}
      readln(ui);
      if ui<>i then
         wa;
   end;

   procedure CheckPrimes(m,n:longint);
   var
      index,maxindex:integer;
      i:longint;
      curprime:boolean;
   begin
      maxindex:=0;
      while sqr(primes[maxindex+1])<=m do
         inc(maxindex);
      for i:=m to n do begin
         curprime:=true;
         for index:=1 to maxindex do
            if i mod primes[index]=0 then begin
               curprime:=false;
               break;
            end;
         if curprime then
            CheckPrime(i);
         if sqr(primes[maxindex])<=i then
            {not sqr(...)=i because primes[0]<2}
            inc(maxindex);
      end;
   end;

var
   m,n,i,ui:longint;
   s:string;
   c:char;
begin
   assign(input,'primes2.in');
   reset(input);
   readln(m,n);
   assign(input,'primes2.out');
   reset(input);
   readln(s);
   if s='Absent' then begin
      if not eof then
         pe;
      for i:=m to n do
         {we can use isPrime here because prime numbers occur very often}
         if isPrime(i) then
            wa;
      a;
   end
   else begin
      {}
      {check that the file contains digits and eol's only}
      reset(input);
      repeat
         if eoln then
            pe;
         read(c);
         if not (c in ['1'..'9']) then
            pe;
         while not eoln do begin
            read(c);
            if not (c in ['0'..'9']) then
               pe;
         end;
         readln;
      until eof;
      {}
      {check that numbers are within longint range}
      reset(input);
      repeat
         {$I-}
         readln(i);
         {$I+}
         if ioresult<>0 then
            pe;
      until eof;
      {}
      {check that numbers are correct}
      reset(input);
      InitPrimeTable;
      CheckPrimes(m,n);
      if not eof then
         wa;{too many numbers or answer should be 'Absent'}
      a;
   end;
end.