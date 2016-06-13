var
	i:integer;
begin
	assign(output,'sums1.i04');
	rewrite(output);
	writeln(500);
	for i:=1 to 7 do
		write(round(exp(ln(2)*(i-1))),' ');
	for i:=8 to 499 do
		write('100 ');
	writeln(100);
end.