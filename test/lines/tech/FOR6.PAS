const
	n=39;
var
	a:array[1..n,1..n]of char;
	i,j:integer;
begin
	if n mod 4<>3 then
		halt;
	for i:=1 to n do
		for j:=1 to n do
			a[i,j]:='.';
	for i:=1 to n div 4 do begin
		for j:=1 to n-1 do
			a[i*4-2,j]:='O';
		for j:=2 to n do
			a[i*4,j]:='O';
	end;
	for j:=1 to n-1 do
		a[n-1,j]:='O';
	a[1,2]:='@';
	a[n,2]:='X';
	assign(output,'lines1.i06');
	rewrite(output);
	writeln(n);
	for i:=1 to n do begin
		for j:=1 to n do
			write(a[i,j]);
		writeln;
	end;
end.