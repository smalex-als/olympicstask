const
   _33=33;
var
   i,j,k:integer;
begin
   writeln(_33);
   for i:=1 to _33 do begin
      for j:=1 to _33 do
         if not odd(i) and not odd(j) then
            write('#')
         else
            write('.');
      writeln;
   end;
end.