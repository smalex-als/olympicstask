{
Written by Fyodor Menshikov 08.04.2002
11:23-11:48
}
{$R-,Q-}
var
   i,j:integer;
   a,b:array[1..30000]of byte;
   alen:integer;
   blen:integer;

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
   assign(output,'scale.out');
   rewrite(output);
   printB;
   close(output);
end.