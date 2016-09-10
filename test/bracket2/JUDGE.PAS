{
Written by Fyodor Menshikov 08.04.2002
11:05-11:16
}
var
   n:integer;
   paren:array[1..20]of char;
   stack:array[1..10]of char;

   procedure print;
   var
      i:integer;
   begin
      for i:=1 to n do
         write(paren[i]);
      writeln;
   end;

   procedure recurs(place,sp,lefts:integer);
   var
      c:char;
   begin
      if place=n+1 then begin
         print;
         exit;
      end;
      if sp>0 then begin
         c:=stack[sp];
         paren[place]:=c;
         recurs(place+1,sp-1,lefts);
         stack[sp]:=c;
      end;
      if lefts>0 then begin
         paren[place]:='(';
         stack[sp+1]:=')';
         recurs(place+1,sp+1,lefts-1);
         paren[place]:='[';
         stack[sp+1]:=']';
         recurs(place+1,sp+1,lefts-1);
      end;
   end;

begin
   assign(input,'bracket2.in');
   reset(input);
   readln(n);
   close(input);
   assign(output,'bracket2.out');
   rewrite(output);
   recurs(1,0,n div 2);
   close(output);
end.