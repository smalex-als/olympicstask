{
Written by Fyodor Menshikov 04.01.2003
10:34-10:40
}
var
   s:string;
   a:array[char]of byte;

   procedure rec(step:integer);
   var
      c:char;
   begin
      if step=length(s)+1 then
         writeln(s)
      else begin
         for c:=#0 to #255 do
            if a[c]>0 then begin
               dec(a[c]);
               s[step]:=c;
               rec(step+1);
               inc(a[c]);
            end;
      end;
   end;

var
   i:integer;
begin
   assign(input,'permut2.in');
   reset(input);
   assign(output,'permut2.out');
   rewrite(output);
   readln(s);
   for i:=1 to length(s) do
      inc(a[s[i]]);
   rec(1);
end.