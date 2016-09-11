{
Written by Fyodor Menshikov 29.07.2002
Internal error format modified 05.01.2004
I/O filename changed 12.01.2005
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

   procedure ie(message:string);
   begin
      writeln('Internal error: ',message);
      while true do;
   end;

const
   wall=-1;
   empty=-2;
   way=-3;
var
   a:array[0..41,0..41]of integer;
   n,ti,tj:integer;

   procedure check;
   var
      u:array[0..41,0..41]of char;

      function neighbour_plus(i,j:integer):integer;
      var
         sum:integer;
      begin
         sum:=0;
         if u[i+1,j]='+' then
            inc(sum);
         if u[i-1,j]='+' then
            inc(sum);
         if u[i,j+1]='+' then
            inc(sum);
         if u[i,j-1]='+' then
            inc(sum);
         neighbour_plus:=sum;
      end;

   var
      answer:string;
      ii,jj:integer;
      count:integer;
      i,j:integer;
      c:char;
   begin
      assign(input,'lines.out');
      reset(input);
      if eoln then
         pe;
      read(answer);
      if not eoln then
         pe;
      readln;
      if answer='N' then begin
         if not eof then
            pe;
         if a[ti,tj]=empty then
            ac
         else
            wa;
      end;
      if answer<>'Y' then
         pe;
      for i:=0 to n+1 do
         for j:=0 to n+1 do
            u[i,j]:='.';
      for i:=1 to n do begin
         for j:=1 to n do begin
            if eoln then
               pe;
            read(c);
            if c in ['.','O','+','@'] then
               u[i,j]:=c
            else
               pe;
         end;
         if not eoln then
            pe;
         readln;
      end;
      if not eof then
         pe;
      for i:=1 to n do
         for j:=1 to n do
            if (a[i,j]=1)xor(u[i,j]='@') then
               pe;
      for i:=1 to n do
         for j:=1 to n do
            if (a[i,j]=wall)xor(u[i,j]='O') then
               pe;
      for i:=1 to n do
         for j:=1 to n do
            if (a[i,j]=empty)and not(u[i,j]='.') then
               pe;
      for i:=1 to n do
         for j:=1 to n do
            if (a[i,j]>1)and not((u[i,j]='.')or(u[i,j]='+')) then
               pe;
      for i:=1 to n do
         for j:=1 to n do
            if u[i,j]='@' then begin
               ii:=i;
               jj:=j;
            end;
      count:=1;
      while true do begin
         case neighbour_plus(ii,jj) of
         0:break;
         1:begin
            inc(count);
            u[ii,jj]:='.';
            if u[ii+1,jj]='+' then
               inc(ii)
            else if u[ii-1,jj]='+' then
               dec(ii)
            else if u[ii,jj+1]='+' then
               inc(jj)
            else if u[ii,jj-1]='+' then
               dec(jj)
            else
               ie('number of pluses around is 1, but cannot find it');
            u[ii,jj]:='@';
         end;
         else
            pe;
         end;
      end;
      for i:=1 to n do
         for j:=1 to n do
            if u[i,j]='+' then
               pe;
      if (ii<>ti)or(jj<>tj) then
         pe;
      if count>a[ti,tj] then
         wa;
      if count<a[ti,tj] then
         ie('user has better solution');
      ac;
   end;

var
   i,j,k:integer;
   c:char;
begin
   assign(input,'lines.in');
   reset(input);
   readln(n);
   for i:=0 to n+1 do
      for j:=0 to n+1 do
         a[i,j]:=wall;
   for i:=1 to n do begin
      for j:=1 to n do begin
         read(c);
         case c of
         'O':a[i,j]:=wall;
         '.':a[i,j]:=empty;
         '@':a[i,j]:=1;
         'X':begin
            a[i,j]:=empty;
            ti:=i;
            tj:=j;
         end;
         else
            halt(1);
         end;
      end;
      readln;
   end;
   for k:=1 to n*n do begin
      for i:=1 to n do
         for j:=1 to n do
            if a[i,j]=k then begin
               if a[i+1,j]=empty then
                  a[i+1,j]:=k+1;
               if a[i-1,j]=empty then
                  a[i-1,j]:=k+1;
               if a[i,j+1]=empty then
                  a[i,j+1]:=k+1;
               if a[i,j-1]=empty then
                  a[i,j-1]:=k+1;
            end;
   end;
   check;
end.