{
Written by Fyodor Menshikov 14.03.2002
20:06-20:14
I/O filename changed 12.01.2005
}
{$R-,Q-,S-}
var
   a:array[1..30]of longint;
   sign:array[2..30]of (plus,minus);
   n:integer;
   s:longint;

   procedure show;
   var
      i:integer;
   begin
      write(a[1]);
      for i:=2 to n do begin
         if sign[i]=plus then
            write('+')
         else
            write('-');
         write(a[i]);
      end;
      writeln('=',s);
      close(output);
      halt;
   end;

   procedure recurs(k:integer;sum:longint);
   begin
      if k>1 then begin
         sign[k]:=plus;
         recurs(k-1,sum+a[k]);
         sign[k]:=minus;
         recurs(k-1,sum-a[k]);
      end
      else if sum+a[1]=s then
         show;
   end;

var
   i:integer;
begin
   assign(input,'expr.in');
   reset(input);
   readln(n,s);
   for i:=1 to n do
      read(a[i]);
   close(input);
   assign(output,'expr.out');
   rewrite(output);
   recurs(n,0);
   writeln('No solution');
   close(output);
end.