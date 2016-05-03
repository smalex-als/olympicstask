const
	n=10000;
var
	i:integer;
begin
	assign(output,'incseq1.i04');
	rewrite(output);
	writeln(n);
	for i:=n downto 2 do
		write(i,' ');
	writeln(1);
end.