var
	i:integer;
begin
	assign(output,'sums1.i02');
	rewrite(output);
	writeln(500);
	for i:=1 to 499 do
		write('0 ');
	writeln(0);
end.