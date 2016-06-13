var
	i:integer;
begin
	assign(output,'sums1.i08');
	rewrite(output);
	writeln(500);
	randomize;
	for i:=1 to 499 do
		write(random(101),' ');
	writeln(random(101));
end.