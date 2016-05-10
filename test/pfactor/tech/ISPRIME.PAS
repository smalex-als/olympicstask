	function isPrime(n:longint):boolean;
	var
		i:longint;
	begin
		isPrime:=false;
		for i:=2 to trunc(sqrt(n)) do
			if n mod i=0 then
				exit;
		isPrime:=true;
	end;

var
	m,n,i:longint;
begin
	{readln(m,n);}
	{for i:=m to n do}
	writeln('qq');
	for i:=maxlongint div 2{46340{maxlongint} downto
	maxlongint div 2-100{46300{maxlongint-100} do
		if isPrime(i) then
			writeln(i);
end.