{$A+,B-,D-,E-,F-,G+,I-,L-,N+,O-,P-,Q-,R-,S-,T-,V-,X-,Y-}
{$M 65500,0,655360}
program N03_C ;
type
   ves = array [1..10000] of longint ;
var
   i, j, n, m, w  : integer ;
   p              : longint ;
   a1, a2         : ^ves ;
begin
   new(a1) ;
   new(a2) ;
   for i := 1 to 10000 do begin
      a1^[i] := 0 ;
      a2^[i] := 0 ;
   end ;
   assign(input,'piggy.in') ;
   assign(output,'piggy.out') ;
   reset(input) ;
   rewrite(output) ;
   read(i,j,n) ;
   m := j - i ;
   for i := 1 to n do begin
      read(p,w) ;
      if w > m then continue ;
      if (a1^[w] = 0) or (a1^[w] > p) then a1^[w] := p ;
      if (a2^[w] = 0) or (a2^[w] < p) then a2^[w] := p ;
      for j := w+1 to m do begin
         if (a1^[j-w] > 0) and ((a1^[j-w] + p < a1^[j]) or (a1^[j] = 0)) then a1^[j] := a1^[j-w] + p ;
         if (a2^[j-w] > 0) and ((a2^[j-w] + p > a2^[j]) or (a2^[j] = 0)) then a2^[j] := a2^[j-w] + p ;
      end ;
   end ;
   if a1^[m] = 0 then write('This is impossible.')
   else write(a1^[m],' ',a2^[m]) ;
   close(output) ;
end .