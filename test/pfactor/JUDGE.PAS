{
Written by Fyodor Menshikov 03.01.2003
I/O filename changed 12.01.2005
}
var
   n,i:longint;
begin
   assign(input,'pfactor.in');
   reset(input);
   assign(output,'pfactor.out');
   rewrite(output);
   readln(n);
   i:=2;
   while i<=trunc(sqrt(n)) do begin
      if n mod i=0 then begin
         write(i,'*');
         n:=n div i;
      end
      else
         inc(i);
   end;
   writeln(n);
end.