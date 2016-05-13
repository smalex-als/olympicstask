var
	i:longint;
   stack:array[1..50000]of char;
   sp:longint;
begin
   randomize;
	assign(output,'bracket1.i02');
   rewrite(output);
   writeln(100000);
   sp:=0;
   for i:=1 to 50000 do begin
   	case random(3) of
      0:begin
      	write('(');
         inc(sp);
         stack[sp]:=')';
      end;
      1:begin
      	write('{');
         inc(sp);
         stack[sp]:='}';
      end;
      2:begin
      	write('[');
         inc(sp);
         stack[sp]:=']';
      end;
      end;
   end;
   for sp:=sp downto 1 do
   	write(stack[sp]);
   writeln;
   close(output);
end.