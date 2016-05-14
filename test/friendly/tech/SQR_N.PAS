{
Written by Fyodor Menshikov 26.12.2003
22:26-22:29
1..n div 2/1..30000 works 1:29 so 1..300000 must be 2:28:20
1..n-1/1..30000 works 2:32 so 1..300000 must be 4:13:20
better use max range 1..500000 so n div 2 will work 6:52:00
but... for modern computers it is of course not too much
}
   function sumdiv(n:longint):longint;
   var
      s,i:longint;
   begin
      s:=0;
      {for i:=1 to n div 2 do}
      for i:=1 to n-1 do
         if n mod i=0 then
            s:=s+i;
      sumdiv:=s;
   end;

var
   min,max:longint;
   n,s:longint;
begin
   readln(min,max);
   for n:=min to max do begin
      if n mod 1000=0 then
         writeln(n);
      s:=sumdiv(n);
      if (n<s)and(s<=max)and(n=sumdiv(s)) then
         writeln(n,' ',s);
   end;
end.