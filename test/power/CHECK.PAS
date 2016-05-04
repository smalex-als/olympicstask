{
Written by Fyodor Menshikov 07.09.2002
I/O filename changed 12.01.2005
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

var
   zero:word;
   digits:array[0..10000]of byte;

   procedure check;
   var
      c:char;
      i:word;
   begin
      assign(input,'power.out');
      reset(input);
      if eoln then
         pe;
      read(c);
      if not (c in ['1'..'9']) then
         pe;
      while not eoln do begin
         read(c);
         if not (c in ['0'..'9']) then
            pe;
      end;
      readln;
      if not eof then
         pe;
      reset(input);
      for i:=zero-1 downto 0 do begin
         if eoln then
            wa;
         read(c);
         if digits[i]<>ord(c)-ord('0') then
            wa;
      end;
      if not eoln then
         wa;
      ac;
   end;

var
   a,rem:integer;
   i,j,k:word;
begin
   assign(input,'power.in');
   reset(input);
   readln(a,k);

   for i:=low(digits) to high(digits) do
      digits[i]:=0;
   digits[0]:=1;
   zero:=1;
   for i:=1 to k do begin
      rem:=0;
      for j:=0 to zero do begin
         rem:=rem+digits[j]*a;
         digits[j]:=rem mod 10;
         rem:=rem div 10;
      end;
      if rem<>0 then
         halt(1);
      if digits[zero]<>0 then
         inc(zero);
   end;

   check;
end.