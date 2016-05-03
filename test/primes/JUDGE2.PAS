{
Written by Fyodor Menshikov 27.02.2004
19:42-19:45
works 7.50 for 2..300000 with default keys
works 4.20 for 2..300000 with $N+,E-
I/O filename changed 12.01.2005
}
{$N+,E-}
var
   m,n,i,j:longint;
   absent,prime:boolean;
begin
   assign(input,'primes.in');
   reset(input);
   assign(output,'primes.out');
   rewrite(output);
   readln(m,n);
   absent:=true;
   for i:=m to n do begin
      prime:=true;
      for j:=2 to trunc(sqrt(i)) do
         if i mod j=0 then begin
            prime:=false;
            break;
         end;
      if prime then begin
         writeln(i);
         absent:=false;
      end;
   end;
   if absent then
      writeln('Absent');
end.