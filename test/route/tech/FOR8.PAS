const
	n=250;
var
	i,j:integer;
begin
	assign(output,'route1.i03');
   rewrite(output);
   writeln(n);
   for i:=1 to n do begin
   	for j:=1 to n do
      	write(random(10));
   	writeln;
   end;
   close(output);
end.