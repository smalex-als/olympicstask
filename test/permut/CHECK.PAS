{
Written by Fyodor Menshikov 15.12.2002
6:32-7:17
I/O filename changed 12.01.2005
}
{$M 65520,330000,655360}

   procedure a;
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

   procedure ie;
   begin
      writeln('ie');
      while true do;
   end;

   function fact(n:integer):word;
   begin
      if n>8 then
         ie;
      if n=0 then
         fact:=1
      else
         fact:=fact(n-1)*n;
   end;

type
   tArray=array[0..40320]of char;
   string8=string[8];
var
   arr:array[1..8]of ^tArray;

   function get(i:longint):string8;
   var
      s:string8;
      j:integer;
   begin
      s:='12345678';
      for j:=1 to 8 do
         s[j]:=arr[j]^[i];
      get:=s;
   end;

   procedure swap(i,j:longint);
   var
      k:integer;
   begin
      for k:=1 to 8 do begin
         arr[k]^[0]:=arr[k]^[i];
         arr[k]^[i]:=arr[k]^[j];
         arr[k]^[j]:=arr[k]^[0];
      end;
   end;

   procedure sort(l,r:longint);
   var
      key:string8;
      i,j:longint;
   begin
      if l>=r then
         exit;
      key:=get(l+random(word(r-l+1)));
      i:=l;
      j:=r;
      repeat
         while get(i)<key do
            inc(i);
         while key<get(j) do
            dec(j);
         if i<=j then begin
            swap(i,j);
            inc(i);
            dec(j);
         end;
      until i>j;
      sort(l,j);
      sort(i,r);
   end;

var
   init,cur:set of char;
   initCharCount,curCharCount:integer;
   lineCount:longint;
   c:char;
   i:integer;
begin
   for i:=1 to 8 do
      new(arr[i]);
   assign(input,'permut.in');
   reset(input);
   init:=[];
   initCharCount:=0;
   while not eoln do begin
      read(c);
      inc(initCharCount);
      if c in init then
         ie;
      include(init,c);
   end;
   assign(input,'permut.out');
   reset(input);
   {check that all lines have necessary symbols+line length is ok+line count}
   lineCount:=0;
   while not eof do begin
      cur:=[];
      inc(lineCount);
      curCharCount:=0;
      while not eoln do begin
         read(c);
         inc(curCharCount);
         if not (c in init) then
            pe;{symbol that was not in original string}
         if c in cur then
            pe;{two symbols in current string}
         include(cur,c);
         if lineCount<=40320 then
            arr[curCharCount]^[lineCount]:=c;
      end;
      if curCharCount<>initCharCount then
         pe;{not enough symbols}
      while curCharCount<8 do begin
         inc(curCharCount);
         arr[curCharCount]^[lineCount]:=#13;
      end;
      readln;
   end;
   if lineCount<>fact(initCharCount) then
      wa;
   randomize;
   sort(1,lineCount);
   for lineCount:=2 to lineCount do
      if get(lineCount)=get(lineCount-1) then
         wa;
   a;
end.