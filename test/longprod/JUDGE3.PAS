{
Written by Fyodor Menshikov 17.04.2002
22:03-22:25
I/O file name changed 15.12.2003
}
{$R-,Q-}
type
   tnumber=array[1..15000]of byte;
   tnumber2=array[1..30000]of byte;

   procedure readnum(var n:tnumber);
   var
      c:char;
      i,j,buf:integer;
   begin
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
         dec(i);
         inc(j);
      end;
      readln;
   end;

   function maxdigit(var n:tnumber):integer;
   var
      i:integer;
   begin
      for i:=high(n) downto 1 do
         if n[i]<>0 then
            break;
      maxdigit:=i;
   end;

   procedure prod(var x,y:tnumber;var res:tnumber2);
   var
      lenx,leny:integer;
      ix,iy,ir:integer;
      tmul,tadd:integer;
   begin
      lenx:=maxdigit(x);
      leny:=maxdigit(y);
      for ix:=1 to lenx do begin
         tmul:=0;
         for iy:=1 to leny do begin
            tmul:=tmul+x[ix]*y[iy];
            tadd:=tmul mod 10;
            tmul:=tmul div 10;
            ir:=ix+iy-1;
            while tadd>0 do begin
               tadd:=tadd+res[ir];
               res[ir]:=tadd mod 10;
               tadd:=tadd div 10;
               inc(ir);
            end;
         end;
         ir:=ix+iy;
         tadd:=tmul;
         while tadd>0 do begin
            tadd:=tadd+res[ir];
            res[ir]:=tadd mod 10;
            tadd:=tadd div 10;
            inc(ir);
         end;
      end;
   end;

   procedure writenum(var n:tnumber2);
   var
      i:integer;
   begin
      assign(output,'longprod.out');
      rewrite(output);
      for i:=high(n) downto low(n) do
         if n[i]<>0 then
            break;
      for i:=i downto low(n) do
         write(n[i]);
      writeln;
      close(output);
   end;

var
   m,n:tnumber;
   res:tnumber2;
begin
   assign(input,'longprod.in');
   reset(input);
   readnum(m);
   readnum(n);
   close(input);
   prod(m,n,res);
   writenum(res);
end.