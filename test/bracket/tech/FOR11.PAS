var
	i:longint;
begin
   randomize;
	assign(output,'bracket1.i01');
   rewrite(output);
   writeln(100000);
   for i:=1 to 100000 do begin
   	case random(3) of
      0:write('(');
      1:write('{');
      2:write('[');
      end;
   end;
   writeln;
   close(output);
end.