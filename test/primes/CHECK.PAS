{
Written by Fyodor Menshikov 04.09.2002
10:03-10:32
I/O filename changed 12.01.2005
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

var
   m,n,i,ui:longint;
   s:string;
   c:char;
begin
   assign(input,'primes.in');
   reset(input);
   readln(m,n);
   assign(input,'primes.out');
   reset(input);
   readln(s);
   if s='Absent' then begin
      if not eof then
         pe;
      for i:=m to n do begin
         if isPrime(i) then
            wa;
      end;
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
      for i:=m to n do begin
         if isPrime(i) then begin
            if eof then
               wa;{not enough numbers}
            readln(ui);
            if ui<>i then
               wa;
         end;
      end;
      if not eof then
         wa;{too many numbers or answer should be 'Absent'}
      a;
   end;
end.