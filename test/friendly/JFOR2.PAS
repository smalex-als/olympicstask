{
Written by Fyodor Menshikov 26.12.2003
22:03-22:10
sum greater is much less probable
modified by 22:13
for 1..300_000 works 47s
for 1..500_000 works 0:01:38
for 1..1_000_000 works 0:04:11
}
   function sumdiv(n:longint):longint;
   var
      i:longint;
      sqrtn:longint;
      sum:longint;
   begin
      if n=1 then
         sumdiv:=0
      else begin
         sum:=1;
         sqrtn:=trunc(sqrt(n));
         if sqr(sqrtn)=n then
            sum:=sum-sqrtn;
         for i:=2 to sqrtn do
            if n mod i=0 then
               sum:=sum+i+n div i;
         sumdiv:=sum;
      end;
   end;

var
   min,max:longint;
   n,s:longint;
begin
   readln(min,max);
   for n:=min to max do begin
      s:=sumdiv(n);
      if (n<s)and(s<=max)and(n=sumdiv(s)) then
         writeln('      (',n,',',s,'),');
   end;
end.