var
	i:integer;
begin
   randomize;
	assign(output,'product.i02');
   rewrite(output);
   for i:=1 to 2500 do
   	write(random(10));
   writeln;
   for i:=1 to 2500 do
   	write(random(10));
   writeln;
   close(output);
end.