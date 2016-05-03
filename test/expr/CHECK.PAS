{
Written by Fyodor Menshikov 29.03.2002
8:55-9:35
Если строка длины >250 - PE
Если строка 'No solution' - нет PE
Если строка не равна заданию с заменой пробелов на +/- и добавлением
=результат, то PE
Если результат выданного выражения не истинен - WA
12.01.2004 bug fixed: wa instead of pe when line is not equal to task with +/-
I/O filename changed 12.01.2005
}
{$Q-,R-,S-}

   procedure a;
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

   function check_str:string;
   var
      c:char;
      s:string;
   begin
      s:='';
      while not eoln do begin
         if length(s)>250 then
            pe;
         read(c);
         s:=s+c;
      end;
      check_str:=s;
   end;

   procedure check_eof;
   begin
      if eoln and not eof then
         readln;
      if not eof then
         pe;
   end;

var
   answer:string;
   template:string;

   procedure read_template;
   var
      s1,s2:string;
      n:integer;
   begin
      read(n);
      if seekeoln then;
      readln(s2);
      readln(s1);
      template:=s1+'='+s2;
   end;

var
   x:array[1..30]of longint;
   n:integer;
   sum:longint;
   no_solution:boolean;

   procedure read_data;
   var
      i:integer;
   begin
      readln(n,sum);
      for i:=1 to n do begin
         read(x[i]);
      end;
   end;

   procedure recurs(i:integer;cursum:longint);
   begin
      if i=1 then begin
         if cursum=sum then
            no_solution:=false;
      end
      else begin
         recurs(i-1,cursum+x[i]);
         recurs(i-1,cursum-x[i]);
      end;
   end;

   procedure check_presentation;
   var
      i:integer;
   begin
      answer:=check_str;
      check_eof;
      if answer='No solution' then
         exit;
      if length(answer)<>length(template) then
         pe;
      for i:=1 to length(template) do begin
         if template[i]=#32 then begin
            if not(answer[i] in ['+','-']) then
               pe;
         end
         else begin
            if answer[i]<>template[i] then
               pe;
         end;
      end;
   end;

   procedure check_answer;
   var
      i,j:integer;
      cursum:longint;
   begin
      if answer='No solution' then begin
         if no_solution then
            exit
         else
            wa;
      end;
      cursum:=x[1];
      i:=1;
      for j:=1 to length(answer) do begin
         if answer[j]='=' then
            break
         else if answer[j]='+' then begin
            inc(i);
            cursum:=cursum+x[i];
         end
         else if answer[j]='-' then begin
            inc(i);
            cursum:=cursum-x[i];
         end;
      end;
      if cursum<>sum then
         wa;
   end;

begin
   assign(input,'expr.in');
   reset(input);
   read_template;
   reset(input);
   read_data;
   close(input);
   no_solution:=true;
   recurs(n,x[1]);
   assign(input,'expr.out');
   reset(input);
   check_presentation;
   close(input);
   check_answer;
   a;
end.