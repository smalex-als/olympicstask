{ NEERC'98 Problem "Gangsters"
  Solution by Roman Elizarov
  22.11.98
}
{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program GANGSTER_SOLUTION;

function min ( x, y: integer ): integer;
begin
  if x < y then
    min:= x
  else
    min:= y;
end;

function max ( x, y: integer ): integer;
begin
  if x > y then
    max:= x
  else
    max:= y;
end;

const
  maxn = 100;
  maxk = 100;

type
  gangster = record t, p, s: integer end;

var
  g: array[1..maxn] of gangster;
  n, k, t, i, j, s1, s2, t_this, dt, s_new: integer;
  sum: array[0..maxn, 0..maxk] of integer;
  tmp: gangster;

begin
  assign ( input, 'gangster.in' ); reset ( input );
  assign ( output, 'gangster.out' ); rewrite ( output );

 { Reading input }
  read ( n, k, t );
  for i:= 1 to n do
    read ( g[i].t );
  for i:= 1 to n do
    read ( g[i].p );
  for i:= 1 to n do
    read ( g[i].s );

 { Solving - sort the gangsters first }
  for i:= 1 to n-1 do
    for j:= i+1 to n do
      if g[i].t > g[j].t then begin
        tmp:= g[i];
        g[i]:= g[j];
        g[j]:= tmp;
      end;

 { Solving - main part }
  t_this:= 0;
  fillchar ( sum, sizeof(sum), $FF ); { sum[*]:= -1 }
  sum[0,0]:= 0;
  for i:= 1 to n do begin { for all gangsters ... }
    dt:= g[i].t - t_this;
    for s1:= 0 to k do
      for s2:= max ( 0, s1 - dt ) to min ( k, s1 + dt ) do
        if (sum[i-1,s2] >= 0) then begin
          s_new:= sum[i-1,s2];
          if s1 = g[i].s then
       inc ( s_new, g[i].p );
          if s_new > sum[i,s1] then
            sum[i,s1]:= s_new;
        end;
    t_this:= g[i].t;
  end;

 { Main part done, identify the best total prosperity }
  s_new:= 0;
  for i:= 0 to k do
    if sum[n,i] > s_new then
      s_new:= sum[n,i];

 { Write output }
  writeln ( s_new );
end.
