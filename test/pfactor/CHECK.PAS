{
Written by Fyodor Menshikov 03.01.2003
Modified into checker 15.12.2003
pe: empty file, not one line, not numbers separated by '*',
    zeros, too long numbers, not increasing order
wa: not prime multiplier, wrong product
Bug fixed 16.12.2003
I/O filename changed 12.01.2005
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

   function int2str(value:longint):string;
   var
      s:string;
   begin
      str(value,s);
      int2str:=s;
   end;

var
   c:char;

   procedure nextchar;
   begin
      if eoln then{cannot just read char - may be eof or eoln}
         c:=#13
      else
         read(c);
   end;

   procedure parsenumber(var value:longint);
   var
      d:integer;
   begin
      if not (c in ['1'..'9']) then
         pe;{zero number or wrong line format}
      value:=ord(c)-ord('0');
      nextchar;
      while c in ['0'..'9'] do begin
         d:=ord(c)-ord('0');
         if value>(maxlongint-d)div 10 then
            pe;{too long number}
         value:=value*10+d;
         nextchar;
      end;
   end;

   procedure parse;
   var
      prev,cur:longint;
   begin
      parsenumber(prev);
      while c='*' do begin
         nextchar;
         parsenumber(cur);
         if cur<prev then
            pe;{not in increasing order}
         prev:=cur;
      end;
   end;

var
   n,i:longint;
   correct,answer:string;
begin
   assign(input,'pfactor.in');
   reset(input);
   readln(n);
   correct:='';
   i:=2;
   while i<=trunc(sqrt(n)) do begin
      if n mod i=0 then begin
         correct:=correct+int2str(i)+'*';
         n:=n div i;
      end
      else
         inc(i);
   end;
   correct:=correct+int2str(n);
   assign(input,'pfactor.out');
   reset(input);
   {checking that there is one non-empty line}
   if eoln then
      pe;
   readln;
   if not eof then
      pe;
   reset(input);
   {checking that there are groups of digits separated by '*'}
   nextchar;
   parse;
   if c<>#13 then
      pe;
   reset(input);
   {checking literal equality}
   readln(answer);
   if answer<>correct then
      wa;
   ac;
end.