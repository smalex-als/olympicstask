{
Written by Fyodor Menshikov 07.09.2002
I/O file name changed 17.11.2003
I/O filename changed 12.01.2005
}
{$R+,B-}
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

const
   ans:array[1..8]of string=(
      'Impossible',
      'Four of a Kind',
      'Full House',
      'Three of a Kind',
      'Two Pairs',
      'One Pair',
      'Straight',
      'Nothing'
   );
   Impossible=1;
   Four_of_a_Kind=2;
   Full_House=3;
   Three_of_a_Kind=4;
   Two_Pairs=5;
   One_Pair=6;
   Straight=7;
   Nothing=8;

   procedure check(index:integer);
   var
      answer:string;
      i:integer;
   begin
      assign(input,'poker.out');
      reset(input);
      readln(answer);
      if not eof then
         pe;
      for i:=low(ans) to high(ans) do
         if ans[i]=answer then begin
            if i=index then
               ac
            else
               wa;
         end;
      pe;
   end;

var
   a:array[1..5]of integer;
   b:array[1..13]of integer;
   c:array[0..5]of integer;

   function isStraight:boolean;
   var
      i:integer;
   begin
      for i:=1 to 13 do begin
         if b[i]<>0 then begin
            isStraight:=(b[i]=1)and(b[i+1]=1)and(b[i+2]=1)and(b[i+3]=1)and(b[i+4]=1);
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

   if c[5]=1 then
      check(Impossible)
   else if c[4]=1 then
      check(Four_of_a_Kind)
   else if (c[3]=1)and(c[2]=1) then
      check(Full_House)
   else if c[3]=1 then
      check(Three_of_a_Kind)
   else if c[2]=2 then
      check(Two_Pairs)
   else if c[2]=1 then
      check(One_Pair)
   else if isStraight then
      check(Straight)
   else
      check(Nothing);
end.