
   function longrand:longint;
   begin
      longrand:=random(5000)*longint(10000)+random(10000);
   end;

const
   n=24;
var
   i:integer;
   sum,t:longint;
   a:array[1..n]of longint;
begin
   assign(output,'expr1.i05');
   rewrite(output);
   randomize;
   for i:=1 to n do
      a[i]:=longrand;
   sum:=a[1];
   for i:=2 to n do begin
      case random(2) of
      0:inc(sum,a[i]);
      1:dec(sum,a[i]);
      else
         halt(1);
      end;  
   end;
   writeln(n,' ',sum);
   for i:=1 to n-1 do
      write(a[i],' ');
   writeln(a[n]);
end.
