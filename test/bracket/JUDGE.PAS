{
Written by Fyodor Menshikov 01.04.2002
20:12-20:21
Debugged 18.08.2004
I/O filename changed 12.01.2005
}

   procedure print(msg:string);
   begin
      close(input);
      assign(output,'bracket.out');
      rewrite(output);
      writeln(msg);
      close(output);
      halt;
   end;

var
   stack:array[1..50001]of char;
   sp:word;

   procedure push(c:char);
   begin
      inc(sp);
      if sp>50000 then
         print('No');
      stack[sp]:=c;
   end;

   function pop:char;
   begin
      if sp=0 then
         print('No');
      pop:=stack[sp];
      dec(sp);
   end;

var
   n,i:longint;
   ch:char;
begin
   assign(input,'bracket.in');
   reset(input);
   readln(n);
   sp:=0;
   for i:=1 to n do begin
      read(ch);
      case ch of
      '(':push('(');
      '[':push('[');
      '{':push('{');
      ')':if pop<>'(' then print('No');
      ']':if pop<>'[' then print('No');
      '}':if pop<>'{' then print('No');
      else
         halt(1);
      end;
   end;
   if sp<>0 then
      print('No');
   print('Yes');
end.