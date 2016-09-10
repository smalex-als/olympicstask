{
Written by Fyodor Menshikov 08.04.2002
11:05-11:16
Modified into checker 29.12.2003
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

   procedure pe(id:integer);
   begin
      writeln('pe'{,id});
      halt(2);
   end;

   procedure ie(message:string);
   begin
      writeln('Internal error: ',message);
      while true do;
   end;

type
   ta=array[1..54912]of byte;{length for anstwer for n=14}
var
   ua:array[1..4]of ^ta;

   procedure init;
   var
      i:integer;
   begin
      for i:=1 to 4 do
         new(ua[i]);
   end;

   procedure put(index:longint;data:longint);
   var
      convert:record
      case byte of
      0:(long:longint;);
      1:(b:array[1..4]of byte;)
      end;
   begin
      convert.long:=data;
      ua[1]^[index]:=convert.b[1];
      ua[2]^[index]:=convert.b[2];
      ua[3]^[index]:=convert.b[3];
      ua[4]^[index]:=convert.b[4];
   end;

   function get(index:longint):longint;
   var
      convert:record
      case byte of
      0:(long:longint;);
      1:(b:array[1..4]of byte;)
      end;
   begin
      convert.b[1]:=ua[1]^[index];
      convert.b[2]:=ua[2]^[index];
      convert.b[3]:=ua[3]^[index];
      convert.b[4]:=ua[4]^[index];
      get:=convert.long;
   end;

   function bcode(c:char):integer;
   begin
      case c of
      '(':bcode:=0;
      '[':bcode:=1;
      ')':bcode:=2;
      ']':bcode:=3;
      else
         ie('bcode');
      end;
   end;

var
   n:integer;

   procedure encode(var s:string;var long:longint);
   var
      i:integer;
   begin
      if length(s)>16 then
         ie('encode');
      long:=0;
      for i:=1 to length(s) do
         long:=long*4+bcode(s[i]);
   end;

   procedure puts(index:longint;var s:string);
   var
      data:longint;
   begin
      encode(s,data);
      put(index,data);
   end;

   procedure qsort(l,r:longint);
   var
      i,j:longint;
      key:longint;
      buf:longint;
   begin
      key:=get((l+r)div 2);
      i:=l;
      j:=r;
      repeat
         while get(i)<key do
            inc(i);
         while key<get(j) do
            dec(j);
         if i<=j then begin
            buf:=get(i);
            put(i,get(j));
            put(j,buf);
            inc(i);
            dec(j);
         end;
      until i>j;
      if l<j then
         qsort(l,j);
      if i<r then
         qsort(i,r);
   end;

var
   judgecount,usercount:longint;
var
   paren:array[1..20]of char;
   stack:array[1..20]of char;

   procedure format(s:string);
   var
      sp,i:integer;
   begin
      if length(s)<>n then
         pe(1);
      sp:=0;
      for i:=1 to length(s) do begin
         case s[i] of
         '(':begin
            inc(sp);
            stack[sp]:=')';
         end;
         '[':begin
            inc(sp);
            stack[sp]:=']';
         end;
         ')',']':begin
            if sp=0 then
               pe(2);
            if stack[sp]<>s[i] then
               pe(3);
            dec(sp);
         end;
         else
            pe(4);
         end;
      end;
      if sp<>0 then
         pe(5);
   end;

   procedure recurs(place,sp,lefts:integer);
   var
      c:char;
   begin
      if place=n+1 then begin
         inc(judgecount);
         exit;
      end;
      if sp>0 then begin
         c:=stack[sp];
         paren[place]:=c;
         recurs(place+1,sp-1,lefts);
         stack[sp]:=c;
      end;
      if lefts>0 then begin
         paren[place]:='(';
         stack[sp+1]:=')';
         recurs(place+1,sp+1,lefts-1);
         paren[place]:='[';
         stack[sp+1]:=']';
         recurs(place+1,sp+1,lefts-1);
      end;
   end;

var
   s:string;
   i:longint;
begin
   assign(input,'bracket2.in');
   reset(input);
   readln(n);
   if (n<2)or(14<n)or odd(n) then
      ie('strange n');
   judgecount:=0;
   recurs(1,0,n div 2);
   assign(input,'bracket2.out');
   reset(input);
   init;
   usercount:=0;
   while not eof do begin
      readln(s);
      inc(usercount);
      format(s);
      if usercount<=judgecount then
         puts(usercount,s);
   end;
   if usercount<>judgecount then
      wa;{double or missing}
   qsort(1,usercount);
   for i:=2 to usercount do begin
      if get(i)=get(i-1) then
         wa;
      if get(i)<get(i-1) then
         ie('qsort failed');
   end;
   ac;
end.
