const
	n=10000;
var
	i:integer;
begin
	assign(output,'incseq1.i02');
	rewrite(output);
	writeln(n);
	randomize;
	for i:=1 to n-1 do
		write(random(60000)+1,' ');
	writeln(random(60000)+1);
end.