var
	i:integer;
begin
	assign(output,'sums1.i07');
	rewrite(output);
	writeln(500);
	write('1 2 6 8 16 32 64');
	for i:=8 to 500 do
		write(' 96');
	writeln;
end.