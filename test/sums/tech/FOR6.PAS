var
	i:integer;
begin
	assign(output,'sums1.i06');
	rewrite(output);
	writeln(500);
	write('1 3 4 8 16 32 64');
	for i:=8 to 500 do
		write(' 100');
	writeln;
end.