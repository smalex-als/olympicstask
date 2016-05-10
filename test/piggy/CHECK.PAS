{
Written by Fyodor Menshikov 01.04.2002
20:29-20:43
Modified into checker 15.12.2003
100->500 changed 27.02.2004
06.01.2005 bug fixed - "-1 -1" instead of "This is impossible." was Ok
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

var
   n:integer;
   e,f:integer;
   p:array[1..500]of longint;
   w:array[1..500]of word;
   i:integer;
   min,max,m:longint;
   sum:array[0..10000]of longint;
   weight,coin:integer;
   umin,umax:longint;
   answer:string;
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

   assign(input,'piggy.out');
   reset(input);
   readln(answer);
   if not eof then
      pe;
   if answer='This is impossible.' then begin
      if min<>-1 then
         wa;
      ac;
   end;
   reset(input);
   {$I-}
   read(umin);
   {$I+}
   if ioresult<>0 then
      pe;
   {$I-}
   read(umax);
   {$I+}
   if ioresult<>0 then
      pe;
   if not eoln then
      pe;
   readln;
   if not eof then
      pe;
   if (umin<0) or (umax<0) then
      pe;
   if (umin<>min)or(umax<>max) then
      wa;
   ac;
end.