var
	i:integer;
begin
	randomize;
   for i:=1 to 10000 do begin
   	writeln(
			random(13)+1,' ',
			random(13)+1,' ',
			random(13)+1,' ',
			random(13)+1,' ',
			random(13)+1);
   end;
end.