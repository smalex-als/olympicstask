{
Written by Fyodor Menshikov 01.04.2002
20:21-20:28
I/O filename changed 07.01.2004
I/O filename changed 12.01.2005
}
var
   sum:array[1..40]of integer;

   procedure show(till:integer);
   var
      i:integer;
   begin
      write(sum[1]);
      for i:=2 to till do
         write('+',sum[i]);
      writeln;
   end;

   procedure recurse(step,start,left:integer);
   var
      i:integer;
   begin
      if start>left then
         exit;
      if step>1 then begin
         sum[step]:=left;
         show(step);
      end;
      for i:=start to left do begin
         sum[step]:=i;
         recurse(step+1,i,left-i);
      end;
   end;
var
   n:integer;
begin
   assign(input,'decomp.in');
   reset(input);
   readln(n);
   close(input);
   assign(output,'decomp.out');
   rewrite(output);
   recurse(1,1,n);
   close(output);
end.