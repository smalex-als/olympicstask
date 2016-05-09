{
Written by Fyodor Menshikov 28.03.2002
17:59-18:07
check 08.12.2002
I/O file names changed 15.12.2003
}
const
   numlen=30001;
type
   tnumber=array[1..numlen]of byte;

   procedure readnum(var n:tnumber);
   var
      i,j:integer;
      c:char;
      buf:byte;
   begin
      for i:=1 to numlen do
         n[i]:=0;
      i:=0;
      while not eoln do begin
         read(c);
         inc(i);
         n[i]:=ord(c)-ord('0');
      end;
      readln;
      j:=1;
      while j<i do begin
         buf:=n[i];
         n[i]:=n[j];
         n[j]:=buf;
         inc(j);
         dec(i);
      end;
   end;

   procedure add(var n1,n2:tnumber);
   var
      i,tmp:integer;
   begin
      tmp:=0;
      for i:=1 to numlen do begin
         tmp:=tmp+n1[i]+n2[i];
         n1[i]:=tmp mod 10;
         tmp:=tmp div 10;
      end;
      if tmp<>0 then
         halt(1);
   end;

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

   procedure check(var n:tnumber);
   var
      i:integer;
      c:char;
   begin
      for i:=numlen downto 1 do
         if n[i]<>0 then
            break;
      assign(input,'longsum.out');
      reset(input);
      if eoln then
         pe;
      read(c);
      if c='0' then begin
         if not eoln then
            pe;
         readln;
         if not eof then
            pe;
         if (i=1)and(n[1]=0) then
            a
         else
            wa;
      end
      else if not (c in ['1'..'9']) then
         pe;
      {check that it is a number}
      while not eoln do begin
         read(c);
         if not (c in ['0'..'9']) then
            pe;
      end;
      readln;
      if not eof then
         pe;
      assign(input,'longsum.out');
      reset(input);
      {check that equal}
      for i:=i downto 1 do begin
         if eoln then
            wa;
         read(c);
         if c<>chr(n[i]+ord('0')) then
            wa;
      end;
      if not eoln then
         wa;
      a;
   end;

var
   m,n:tnumber;
begin
   assign(input,'longsum.in');
   reset(input);
   readnum(n);
   readnum(m);
   add(n,m);
   check(n);
end.