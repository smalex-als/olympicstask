var
   i,j:integer;
begin
   randomize;
   writeln(33);
   for i:=1 to 33 do begin
      for j:=1 to 33 do
         if random(4)=0 then
            write('#')
         else
            write('.');
      writeln;
   end;
end.