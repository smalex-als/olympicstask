var
	i:integer;
begin
	assign(output,'sums1.i03');
	rewrite(output);
	writeln(500);
	for i:=1 to 499 do
		write('100 ');
	writeln(100);
end.