const
	n=40;
var
	a:array[1..n,1..n]of char;
	i,j:integer;
	r:real;
begin
	for i:=1 to n do
		for j:=1 to n do
			a[i,j]:='.';
	for i:=1 to n do
		for j:=1 to n do begin
			r:=sqrt(sqr(i-(n+1)/2)+sqr(j-(n+1)/2));
			if (r>n/2-3)and(r<n/2-1) then
				a[i,j]:='O';
		end;
	a[1,1]:='@';
	a[n,n]:='X';
	assign(output,'lines1.i05');
	rewrite(output);
	writeln(n);
	for i:=1 to n do begin
		for j:=1 to n do
			write(a[i,j]);
		writeln;
	end;
end.