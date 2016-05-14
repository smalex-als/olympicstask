{
Written by Fyodor Menshikov 26.12.2003
22:26-22:29
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
   absent:boolean;
begin
   assign(input,'friendly.in');
   reset(input);
   assign(output,'friendly.out');
   rewrite(output);
   readln(min,max);
   absent:=true;
   for n:=min to max do begin
      s:=sumdiv(n);
      if (n<s)and(s<=max)and(n=sumdiv(s)) then begin
         writeln(n,' ',s);
         absent:=false;
      end;
   end;
   if absent then
      writeln('Absent');
end.
