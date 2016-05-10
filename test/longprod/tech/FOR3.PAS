var
	i:integer;
begin
   randomize;
	assign(output,'product.i03');
   rewrite(output);
   write(1);
   for i:=1 to 2500 do
   	write(0);
   writeln;
   write(1);
   for i:=1 to 2500 do
   	write(0);
   writeln;
   close(output);
end.