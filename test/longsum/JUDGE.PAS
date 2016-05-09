{
Written by Fyodor Menshikov 28.03.2002
17:59-18:07
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

   procedure writenum(var n:tnumber);
   var
      i:integer;
   begin
      for i:=numlen downto 1 do
         if n[i]<>0 then
            break;
      for i:=i downto 1 do
         write(n[i]);
      writeln;
   end;

var
   m,n:tnumber;
begin
   assign(input,'longsum.in');
   reset(input);
   readnum(n);
   readnum(m);
   close(input);
   add(n,m);
   assign(output,'longsum.out');
   rewrite(output);
   writenum(n);
   close(output);
end.