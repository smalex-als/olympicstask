var
   i:integer;
begin
   randomize;
   assign(output,'longprod.in');
   rewrite(output);
   write(random(9)+1);
   for i:=2 to 10000 do
      write(random(10));
   writeln;
   write(random(9)+1);
   for i:=2 to 10000 do
      write(random(10));
   writeln;
   close(output);
end.