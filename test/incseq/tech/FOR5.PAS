const
	n=10000;
var
	i:integer;
begin
	assign(output,'incseq1.i05');
	rewrite(output);
	writeln(n);
	randomize;
	for i:=1 to n-1 do
		write(i+random(n),' ');
	writeln(n+random(n));
end.