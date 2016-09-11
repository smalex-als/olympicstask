const
	n=38;
var
	a:array[1..n,1..n]of char;
	i,j:integer;
begin
	if n mod 6<>2 then
		halt;
	for i:=1 to n do
		for j:=1 to n do
			a[i,j]:='.';
	for i:=1 to n div 6 do begin
		for j:=1 to n-2 do
			a[i*6-3,j]:='O';
		for j:=3 to n do
			a[i*6,j]:='O';
	end;
	a[1,2]:='@';
	a[n,n-1]:='X';
	assign(output,'lines1.i07');
	rewrite(output);
	writeln(n);
	for i:=1 to n do begin
		for j:=1 to n do
			write(a[i,j]);
		writeln;
	end;
end.