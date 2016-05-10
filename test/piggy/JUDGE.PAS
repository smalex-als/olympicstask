{
Written by Fyodor Menshikov 01.04.2002
20:29-20:43
100->500 changed 27.02.2004
}
var
   n:integer;
   e,f:integer;
   p:array[1..500]of longint;
   w:array[1..500]of word;
   i:integer;
   min,max,m:longint;
   sum:array[0..10000]of longint;
   weight,coin:integer;
begin
   assign(input,'piggy.in');
   reset(input);
   readln(e,f);
   readln(n);
   for i:=1 to n do
      readln(p[i],w[i]);
   close(input);

   sum[0]:=0;
   for weight:=1 to f-e do begin
      m:=-1;{impossible}
      for coin:=1 to n do begin
         if weight-w[coin]>=0 then begin{index Ok}
            if sum[weight-w[coin]]>=0 then begin{possible}
               if (m=-1)or(sum[weight-w[coin]]+p[coin]<m) then begin
                  m:=sum[weight-w[coin]]+p[coin];
               end;
            end;
         end;
      end;
      sum[weight]:=m;
   end;
   min:=sum[weight];

   sum[0]:=0;{impossible}
   for weight:=1 to f-e do begin
      m:=-1;
      for coin:=1 to n do begin
         if weight-w[coin]>=0 then begin{index Ok}
            if sum[weight-w[coin]]>=0 then begin{possible}
               if sum[weight-w[coin]]+p[coin]>m then begin
                  m:=sum[weight-w[coin]]+p[coin];
               end;
            end;
         end;
      end;
      sum[weight]:=m;
   end;
   max:=sum[weight];

   assign(output,'piggy.out');
   rewrite(output);
   if (min=-1)or(max=-1) then begin
      if (min<>-1)or(max<>-1) then
         halt(1);
      writeln('This is impossible.');
   end
   else
      writeln(min,' ',max);
   close(output);
end.