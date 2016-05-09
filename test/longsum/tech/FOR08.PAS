	procedure writeline;
   var
   	i:integer;
   begin
   	for i:=1 to random(30000) do
      	write(random(10));
      writeln;
   end;

begin
	assign(output,'sum.i01');
   rewrite(output);
   randomize;
   writeline;
   writeline;
   close(output);
end.