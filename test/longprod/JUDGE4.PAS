{
Written by Fyodor Menshikov 26.02.2004
1:56-2:06
Idea by Yaroslav Muzykantov
}
var
   i,j,t,mult,carry,ib,iax,digit:integer;
   c:char;
   a,b:array[1..2502]of byte;
   ax:array[0..9,1..2502]of byte;
   rez:array[1..5004]of byte;
begin
   assign(input,'longprod.in');
   reset(input);
   assign(output,'longprod.out');
   rewrite(output);
   i:=0;
   while not eoln do begin
      read(c);
      inc(i);
      a[i]:=ord(c)-ord('0');
   end;
   readln;
   j:=1;
   while j<i do begin
      t:=a[i];
      a[i]:=a[j];
      a[j]:=t;
      inc(j);
      dec(i);
   end;
   i:=0;
   while not eoln do begin
      read(c);
      inc(i);
      b[i]:=ord(c)-ord('0');
   end;
   readln;
   j:=1;
   while j<i do begin
      t:=b[i];
      b[i]:=b[j];
      b[j]:=t;
      inc(j);
      dec(i);
   end;
   {}
   for mult:=1 to 9 do begin
      carry:=0;
      for i:=1 to 2502 do begin
         carry:=carry+ax[mult-1,i]+a[i];
         ax[mult,i]:=carry mod 10;
         carry:=carry div 10;
      end;
      if carry<>0 then
         halt(1);
   end;
   {}
   for ib:=1 to 2502 do begin
      carry:=0;
      digit:=b[ib];
      for iax:=1 to 2502 do begin
         carry:=carry+rez[ib+iax-1]+ax[digit,iax];
         rez[ib+iax-1]:=carry mod 10;
         carry:=carry div 10;
      end;
      if carry<>0 then
         halt(1);
   end;
   {}
   i:=5004;
   while (i>1)and(rez[i]=0) do
      dec(i);
   for i:=i downto 1 do
      write(rez[i]);
   writeln;
end.