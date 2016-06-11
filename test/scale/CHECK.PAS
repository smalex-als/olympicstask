{
Written by Fyodor Menshikov 08.04.2002
11:23-11:48
Modified into checker 30.12.2003
}
{$R-,Q-}
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
   i,j:integer;
   a,b:array[1..30000]of byte;
   alen:integer;
   blen:integer;

   function i2c(int:integer):char;
   begin
      case int of
      0..9:i2c:=chr(ord('0')+int);
      10..35:i2c:=chr(ord('A')+(int-10));
      else
         ie('i2c');
      end;
   end;

   function c2i(c:char):integer;
   begin
      case c of
      '0'..'9':c2i:=ord(c)-ord('0');
      'A'..'Z':c2i:=ord(c)-ord('A')+10;
      else
         ie('c2i');
      end;
   end;

   procedure checkB;
   var
      possibleChars:set of char;
      index:integer;
   begin
      possibleChars:=[];
      for index:=0 to j-1 do
         include(possibleChars,i2c(index));
      assign(input,'scale.out');
      reset(input);
      nextchar;
      if c='0' then
         nextchar
      else if c in possibleChars then begin
         nextchar;
         while c in possibleChars do
            nextchar;
      end
      else
         pe;
      if c<>#13 then
         pe;
      readln;
      if not eof then
         pe;
      reset(input);
      for index:=blen downto 1 do begin
         nextchar;
         if c<>i2c(b[index]) then
            wa;
      end;
      nextchar;
      if c<>#13 then
         wa;
      ac;
   end;

   procedure readnum;
   var
      c:char;
      hi,lo,buf:integer;
   begin
      hi:=0;
      while not eoln do begin
         read(c);
         inc(hi);
         case c of
         '0'..'9':a[hi]:=ord(c)-ord('0');
         'A'..'Z':a[hi]:=ord(c)-ord('A')+10;
         else
            halt(1);
         end;
      end;
      alen:=hi;
      lo:=1;
      while lo<hi do begin
         buf:=a[hi];
         a[hi]:=a[lo];
         a[lo]:=buf;
         inc(lo);
         dec(hi);
      end;
   end;

   function ZeroA:boolean;
   var
      index:integer;
   begin
      ZeroA:=false;
      for index:=1 to alen do
         if a[index]<>0 then
            exit;
      ZeroA:=true;
   end;

   function reminder:integer;
   var
      rem:integer;
      index:integer;
   begin
      rem:=0;
      for index:=alen downto 1 do begin
         rem:=rem*i+a[index];
         a[index]:=rem div j;
         rem:=rem mod j;
      end;
      reminder:=rem;
   end;

   procedure printB;
   var
      index:integer;
      c:char;
   begin
      for index:=30000 downto 1 do
         if b[index]<>0 then
            break;
      for index:=index downto 1 do begin
         case b[index] of
         0..9:c:=chr(b[index]+ord('0'));
         10..35:c:=chr(b[index]-10+ord('A'));
         else
            halt(2);
         end;
         write(c);
      end;
      writeln;
   end;

begin
   assign(input,'scale.in');
   reset(input);
   readln(i,j);
   readnum;
   close(input);
   blen:=0;
   repeat
      inc(blen);
      b[blen]:=reminder;
   until ZeroA;
   checkB;
end.