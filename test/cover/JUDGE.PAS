{
Written by Fyodor Menshikov 28.03.2002
17:10-17:25
}
type
   arr=array[1..15001]of longint;
var
   l,r:^arr;

   procedure quick(left,right:integer);
   var
      i,j:integer;
      buf:longint;
      key:longint;
   begin
      key:=l^[(left+right)div 2];
      i:=left;
      j:=right;
      repeat
         while l^[i]<key do
            inc(i);
         while l^[j]>key do
            dec(j);
         if i<=j then begin
            buf:=l^[i];
            l^[i]:=l^[j];
            l^[j]:=buf;
            buf:=r^[i];
            r^[i]:=r^[j];
            r^[j]:=buf;
            inc(i);
            dec(j);
         end;
      until i>j;
      if left<j then
         quick(left,j);
      if i<right then
         quick(i,right);
   end;

var
   n,i,cur:integer;
   sum:longint;
begin
   new(l);
   new(r);
   assign(input,'cover.in');
   reset(input);
   readln(n);
   for i:=1 to n do begin
      readln(l^[i],r^[i]);
   end;
   close(input);
   quick(1,n);
   l^[n+1]:=1000000001;
   r^[n+1]:=1000000002;
   cur:=1;
   sum:=0;
   for i:=2 to n+1 do begin
      if r^[cur]<l^[i] then begin
         sum:=sum+(r^[cur]-l^[cur]);
         cur:=i;
      end
      else if r^[i]>r^[cur] then
         r^[cur]:=r^[i];
   end;
   assign(output,'cover.out');
   rewrite(output);
   writeln(sum);
   close(output);
end.
