{
Written by Fyodor Menshikov 01.04.2002
21:04-21:11
I/O file name changed 22.12.2003
}
var
   m:array[0..60001]of byte;
   i,j,mlen:word;
   n,rem:longint;
   ch:char;
begin
   assign(input,'divshort.in');
   reset(input);
   mlen:=0;
   while not eoln do begin
      read(ch);
      inc(mlen);
      m[mlen]:=ord(ch)-ord('0');
   end;
   readln(n);
   close(input);
   i:=1;
   j:=mlen;
   while i<j do begin
      m[0]:=m[i];
      m[i]:=m[j];
      m[j]:=m[0];
      inc(i);
      dec(j);
   end;
   rem:=0;
   for i:=mlen downto 1 do begin
      rem:=rem*10+m[i];
      m[i]:=rem div n;
      rem:=rem mod n;
   end;
   assign(output,'divshort.out');
   rewrite(output);
   for i:=mlen downto 1 do
      if m[i]<>0 then
         break;
   for i:=i downto 1 do
      write(m[i]);
   writeln;
   writeln(rem);
   close(output);
end.