{
Written by Fyodor Menshikov 01.04.2002
20:12-20:21
Modified into checker 22.12.2003
Debugged 18.08.2004
I/O filename changed 12.01.2005
}
   procedure ac;
   begin
      writeln('a');
      halt(0);
   end;

   procedure wa;
   begin
      writeln('wa');
      halt(1);
   end;

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

   procedure ie(message:string);
   begin
      writeln('Internal error: ',message);
      while true do;
   end;

   procedure check(judgeanswer:string);
   var
      useranswer:string;
   begin
      assign(input,'bracket.out');
      reset(input);
      readln(useranswer);
      if not eof then
         pe;
      if (useranswer<>'Yes') and (useranswer<>'No') then
         pe;
      if useranswer<>judgeanswer then
         wa;
      ac;
   end;

var
   stack:array[1..50001]of char;
   sp:word;

   procedure push(c:char);
   begin
      inc(sp);
      if sp>50000 then
         check('No');
      stack[sp]:=c;
   end;

   function pop:char;
   begin
      if sp=0 then
         check('No');
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
      ')':if pop<>'(' then check('No');
      ']':if pop<>'[' then check('No');
      '}':if pop<>'{' then check('No');
      else
         ie('unknown bracket type');
      end;
   end;
   if sp<>0 then
      check('No');
   check('Yes');
end.