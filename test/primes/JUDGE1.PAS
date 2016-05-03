{
Written by Fyodor Menshikov 27.02.2004
19:48-19:51
works 7:70 for 2..300000 with default keys
works 4.40 for 2..300000 with $N+,E-
I/O filename changed 12.01.2005
}
{$N+,E-}
var
   m,n,i,j,sqrti:longint;
   absent,prime:boolean;
begin
   assign(input,'primes.in');
   reset(input);
   assign(output,'primes.out');
   rewrite(output);
   readln(m,n);
   absent:=true;
   for i:=m to n do begin
      sqrti:=trunc(sqrt(i));
      prime:=true;
      j:=2;
      while prime and (j<=sqrti) do begin
         if i mod j=0 then
            prime:=false;
         inc(j);
      end;
      if prime then begin
         writeln(i);
         absent:=false;
      end;
   end;
   if absent then
      writeln('Absent');
end.