var
	i:integer;
begin
   randomize;
	assign(output,'product.i01');
   rewrite(output);
   for i:=1 to 20 do
   	write(random(10));
   writeln;
   for i:=1 to 20 do
   	write(random(10));
   writeln;
   close(output);
end.