const
	n=10000;
var
	i:integer;
begin
	assign(output,'incseq1.i06');
	rewrite(output);
	writeln(n);
	randomize;
	for i:=n downto 2 do
		write(i+random(n),' ');
	writeln(1+random(n));
end.