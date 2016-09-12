const
   _33=33;
var
   lab:array[1.._33,1.._33]of char;
   i,j,k:integer;
   c:char;
begin
   for k:=1 to _33 do begin
      if odd(k) then
         c:='.'
      else
         c:='#';
      for i:=k to _33+1-k do
         for j:=k to _33+1-k do
            lab[i,j]:=c;
   end;
   for k:=1 to _33 do begin
      lab[k,_33 div 2+1]:='.';
      lab[_33 div 2+1,k]:='.';
   end;
   writeln(_33);
   for i:=1 to _33 do begin
      for j:=1 to _33 do
         write(lab[i,j]);
      writeln;
   end;
end.