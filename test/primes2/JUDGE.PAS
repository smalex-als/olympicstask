{
Written by Fyodor Menshikov 14.03.2002
16:42-17:11
on Intel Celeron 400
Q+,R+ 2..1000000 8s
Q-,R- 2..1500000 9s
Modified 24.11.2002
}
{$Q-,R-}

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
   m,n,i:longint;
   primes:array[0..maxP]of longint;
   index,maxindex:integer;
   curprime,absent:boolean;
begin
   assign(input,'primes2.in');
   reset(input);
   readln(m,n);
   close(input);
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
   assign(output,'primes2.out');
   rewrite(output);
   maxindex:=0;
   while sqr(primes[maxindex+1])<=m do
      inc(maxindex);
   absent:=true;
   for i:=m to n do begin
      curprime:=true;
      for index:=1 to maxindex do
         if i mod primes[index]=0 then begin
            curprime:=false;
            break;
         end;
      if curprime then begin
         writeln(i);
         absent:=false;
      end;
      if sqr(primes[maxindex])<=i then
         {not sqr(...)=i because primes[0]<2}
         inc(maxindex);
   end;
   if absent then
      writeln('Absent');
   close(output);
end.