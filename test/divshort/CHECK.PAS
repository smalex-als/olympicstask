{
Written by Fyodor Menshikov 01.04.2002
21:04-21:11
I/O file name changed 22.12.2003
Modified into checker 22.12.2003
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

var
   c:char;

   procedure nextchar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
   end;

var
   m:array[0..60001]of byte;
   rem:longint;

   procedure check;
   var
      cnt:integer;
      i:word;
      userrem:longint;
   begin
      assign(input,'divshort.out');
      reset(input);
      for cnt:=1 to 2 do begin{2 lines, 2 numbers}
         nextchar;
         if c='0' then begin
            nextchar;
         end
         else if c in ['1'..'9'] then begin
            repeat
               nextchar;
            until not (c in ['0'..'9']);
         end
         else
            pe;
         if c<>#13 then
            pe;
         readln;
      end;
      if not eof then
         pe;
      reset(input);
      i:=high(m);
      while (i>1)and(m[i]=0) do
         dec(i);
      for i:=i downto 1 do begin
         nextchar;
         if ord(c)<>m[i]+ord('0') then
            wa;
      end;
      if not eoln then
         wa;
      readln;
      {$I-}
      readln(userrem);
      {$I+}
      if ioresult<>0 then
         wa;{not pe, look is correct}
      if userrem<>rem then
         wa;
      ac;
   end;

var
   n:longint;
   i,j,mlen:word;
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
   check;
end.