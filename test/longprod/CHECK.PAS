{
Written by Fyodor Menshikov 15.12.2003
21:32-21:42
Slightly optimized by 22:06
Modified into checker 15.12.2003
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

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

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

   procedure checkformat;
   var
      c:char;
   begin
      if eoln then
         pe;
      read(c);
      if c='0' then begin
         if not eoln then
            pe;
         readln;
         if not eof then
            pe;
      end
      else if c in ['1'..'9'] then begin
         while not eoln do begin
            read(c);
            if not (c in ['0'..'9']) then
               pe;
         end;
         readln;
         if not eof then
            pe;
      end
      else
         pe;
   end;

   procedure checknumber(var n:number);
   var
      c:char;
      i:integer;
   begin
      for i:=len(n) downto 1 do begin
         if eoln then
            wa;{too short}
         read(c);
         if ord(c)-ord('0')<>n[i] then
            wa;{different digit}
      end;
      if not eoln then
         wa;{too long}
      ac;
   end;

var
   n1,n2,n3:number;
begin
   assign(input,'longprod.in');
   reset(input);
   load(n1);
   load(n2);
   mul(n1,n2,n3);
   assign(input,'longprod.out');
   reset(input);
   checkformat;
   reset(input);
   checknumber(n3);
end.