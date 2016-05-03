const
	n=10000;
var
	i:integer;
begin
	assign(output,'incseq1.i03');
	rewrite(output);
	writeln(n);
	for i:=1 to n-1 do
		write(i,' ');
	writeln(n);
end.