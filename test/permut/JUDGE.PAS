{
Written by Fyodor Menshikov 28.03.2002
17:25-17:35
I/O filename changed 12.01.2005
}
var
   s:string;
   rez:string;
   used:array[1..10]of boolean;
   m:integer;

   procedure recurs(hi:integer);
   var
      i:integer;
   begin
      if hi>m then
         writeln(rez)
      else begin
         for i:=1 to m do begin
            if not used[i] then begin
               rez[hi]:=s[i];
               used[i]:=true;
               recurs(hi+1);
               used[i]:=false;
            end;
         end;
      end;
   end;

var
   i:integer;
begin
   assign(input,'permut.in');
   reset(input);
   readln(s);
   close(input);
   m:=length(s);
   rez[0]:=chr(m);
   for i:=1 to m do
      used[i]:=false;
   assign(output,'permut.out');
   rewrite(output);
   recurs(1);
   close(output);
end.