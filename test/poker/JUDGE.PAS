{
Written by Fyodor Menshikov 29.07.2002
7:52-8:03
I/O file name changed 17.11.2003
}
{$R+,B-}
var
   a:array[1..5]of integer;
   b:array[1..13]of integer;
   c:array[0..5]of integer;

   function Straight:boolean;
   var
      i:integer;
   begin
      for i:=1 to 13 do begin
         if b[i]<>0 then begin
            Straight:=(b[i]=1)and(b[i+1]=1)and(b[i+2]=1)and(b[i+3]=1)and(b[i+4]=1);
            exit;
         end;
      end;
   end;
var
   i:integer;
begin
   assign(input,'poker.in');
   reset(input);
   for i:=1 to 5 do
      read(a[i]);
   for i:=1 to 13 do
      b[i]:=0;
   for i:=1 to 5 do
      inc(b[a[i]]);
   for i:=1 to 5 do
      c[i]:=0;
   for i:=1 to 13 do
      inc(c[b[i]]);
   assign(output,'poker.out');
   rewrite(output);
   if c[5]=1 then
      writeln('Impossible')
   else if c[4]=1 then
      writeln('Four of a Kind')
   else if (c[3]=1)and(c[2]=1) then
      writeln('Full House')
   else if c[3]=1 then
      writeln('Three of a Kind')
   else if c[2]=2 then
      writeln('Two Pairs')
   else if c[2]=1 then
      writeln('One Pair')
   else if Straight then
      writeln('Straight')
   else
      writeln('Nothing');
end.