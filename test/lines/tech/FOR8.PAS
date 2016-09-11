const
	n=39;
var
	a:array[1..n,1..n]of char;
	i,j:integer;
begin
	if n mod 16<>7 then
		halt;
	for i:=1 to n do
		for j:=1 to n do
			a[i,j]:='.';
	for i:=1 to n div 16 do begin
		for j:=1 to n-8 do
			a[i*16-8,j]:='O';
		for j:=9 to n do
			a[i*16,j]:='O';
	end;
	randomize;
	for i:=1 to n do
		for j:=1 to n do
			if random(5)=0 then
				a[i,j]:='O';
	a[1,1]:='@';
	a[n,n]:='X';
	assign(output,'lines1.i08');
	rewrite(output);
	writeln(n);
	for i:=1 to n do begin
		for j:=1 to n do
			write(a[i,j]);
		writeln;
	end;
end.