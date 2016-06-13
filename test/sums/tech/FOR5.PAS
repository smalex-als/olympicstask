var
	i:integer;
begin
	assign(output,'sums1.i05');
	rewrite(output);
	writeln(500);
	for i:=1 to 6 do
		write(round(exp(ln(2)*i)),' ');
	for i:=7 to 499 do
		write('100 ');
	writeln(100);
end.