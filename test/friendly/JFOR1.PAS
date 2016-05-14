{
Written by Fyodor Menshikov 26.12.2003
22:03-22:10
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
   sgt,slt:longint;
begin
   readln(min,max);
   sgt:=0;
   slt:=0;
   for n:=min to max do begin
      s:=sumdiv(n);
      if s<n then
         inc(slt);
      if s>n then
         inc(sgt);
      if n=sumdiv(s) then
         writeln(n,' ',s,' ',slt,' ',sgt);
   end;
end.