{
Written by Fyodor Menshikov 14.03.2002
21:42-21:51
9^10000 7s
1 to high every time 14s
R+,Q+ 35s
I/O filename changed 12.01.2005
}
{$R-,Q-}
var
   a,rem:integer;
   i,j,k,zero:word;
   digits:array[0..10000]of byte;
begin
   assign(input,'power.in');
   reset(input);
   readln(a,k);
   close(input);
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
   assign(output,'power.out');
   rewrite(output);
   for i:=zero-1 downto 0 do
      write(digits[i]);
   close(output);
end.