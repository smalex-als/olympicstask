const
	n=30;
var
	i:integer;
begin
	assign(output,'incseq1.i01');
	rewrite(output);
	writeln(n);
	randomize;
	for i:=1 to n-1 do
		write(random(n)+1,' ');
	writeln(random(n)+1);
end.