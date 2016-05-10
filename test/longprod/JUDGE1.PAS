{
Written by Fyodor Menshikov 15.12.2003
21:32-21:42
Slightly optimized by 22:06
Multiplication procedure commented by 22:31
}
type
   number=array[1..20001{5001}]of byte;

   procedure set0(var n:number);
   var
      i:integer;
   begin
      for i:=1 to high(n) do
         n[i]:=0;
   end;

   procedure load(var n:number);
   var
      i,j,buf:integer;
      c:char;
   begin
      set0(n);
      i:=0;
      while not eoln do begin
         read(c);
         inc(i);
         n[i]:=ord(c)-ord('0');
      end;
      j:=1;
      while i>j do begin
         buf:=n[i];
         n[i]:=n[j];
         n[j]:=buf;
         inc(j);
         dec(i);
      end;
      readln;
   end;

   function len(var n:number):integer;
   var
      i:integer;
   begin
      len:=1;
      for i:=1 to high(n) do
         if n[i]<>0 then
            len:=i;
   end;

   procedure mul(var n1,n2,n3:number);
   var
      i1,i2,i3,len1,len2,carry:integer;
   begin
      len1:=len(n1);
      len2:=len(n2);
      set0(n3);
      for i1:=1 to len1 do begin
         i3:=i1;
         carry:=0;
         for i2:=1 to len2 do begin
            carry:=carry+n3[i3]+n1[i1]*n2[i2];
            n3[i3]:=carry mod 10;
            carry:=carry div 10;
            inc(i3);
         end;
         n3[i3]:=carry;
         {first time max carry=(0+9+9*9)div 10=9}
         {every next time max carry=(9+9+9*9)div 10=9}
         {so carry is always in [0..9] - one digit}
         {i3 after "for i2" is equal to i1+len2}
         {i1 is increasing, so i3 is}
         {so n3[i3] is always not used before and equal to 0}
      end;
   end;

   procedure show(var n:number);
   var
      i:integer;
   begin
      i:=high(n);
      while (i>1)and(n[i]=0) do
         dec(i);
      for i:=i downto 1 do
         write(n[i]);
      writeln;
   end;

var
   n1,n2,n3:number;
begin
   assign(input,'longprod.in');
   reset(input);
   assign(output,'longprod.out');
   rewrite(output);
   load(n1);
   load(n2);
   mul(n1,n2,n3);
   show(n3);
end.