var
	i:integer;
begin
	randomize;
	assign(output,'gangster.i08');
   rewrite(output);
   writeln(100,' ',100,' ',30000);
   for i:=1 to 100 do
   	write(random(30001),' ');
   writeln;
   for i:=1 to 100 do
   	write(random(300)+1,' ');
   writeln;
   for i:=1 to 100 do
   	write(random(100)+1,' ');
   writeln;
   close(output);
end.