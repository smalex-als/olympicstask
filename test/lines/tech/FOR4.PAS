const
	n=40;
var
	a:array[1..n,1..n]of char;
	i,j:integer;
begin
	for i:=1 to n do
		for j:=1 to n do
			a[i,j]:='.';
	a[1,1]:='@';
	a[n,n]:='X';
	for i:=1 to n do
		a[i,n+1-i]:='O';
	assign(output,'lines1.i04');
	rewrite(output);
	writeln(n);
	for i:=1 to n do begin
		for j:=1 to n do
			write(a[i,j]);
		writeln;
	end;
end.