{$A+,B-,D-,E-,F-,G+,I-,L-,N+,O-,P-,Q-,R-,S-,T-,V-,X-,Y-}
{$M 65500,0,655360}
program C4 ;
type
   rec = record
      t, p, s : integer ;
   end ;
var
   i, j, k, n, t, l, m : integer ;
   a   : array [1..100] of rec ;
   buf : rec ;
begin
   assign(input,'gangster.in') ;
   assign(output,'gangster.out') ;
   reset(input) ;
   rewrite(output) ;
   read(n,k,t) ;
   for i := 1 to n do read(a[i].t) ;
   for i := 1 to n do read(a[i].p) ;
   for i := 1 to n do read(a[i].s) ;
   for i := 1 to n-1 do begin
      l := i ;
      for j := i+1 to n do if a[j].t < a[l].t then l := j ;
      buf := a[i] ;
      a[i] := a[l] ;
      a[l] := buf ;
   end ;
   for i := 1 to n do begin
      if a[i].t < a[i].s then begin
         a[i].p := 0 ;
         continue ;
      end ;
      m := 0 ;
      for j := 1 to i-1 do
         if (a[i].t - a[j].t >= abs(a[i].s - a[j].s)) and (a[j].p > m) then m := a[j].p ;
      a[i].p := a[i].p + m ;
   end ;
   for i := 1 to n do if a[i].p > m then m := a[i].p ;
   write(m) ;
   close(output) ;
end .