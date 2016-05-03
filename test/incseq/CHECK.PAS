{
Written by Fyodor Menshikov 29.03.2002
8:04-8:54
Если в первой строке нет числа типа word или во второй строке
не столько чисел типа word, сколько указано в первой строке - PE
Если не максимальная, не в порядке возрастания или
не подпоследовательность - WA
I/O filename changed 12.01.2005
}
{$Q-,R-}
{$M 65520,0,655360}

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

   procedure check_not_eoln;
   begin
      if seekeoln then
         pe;
   end;

   procedure check_eoln;
   begin
      if eoln and not eof then
         readln
      else
         pe;
   end;

   procedure check_eof;
   begin
      if seekeoln and not eof then
         readln;
      if not eof then
         pe;
   end;

   function check_word:word;
   var
      w:word;
   begin
      {$i-}
      read(w);
      {$i+}
      if ioresult<>0 then
         pe;
      check_word:=w;
   end;

   procedure check_presentation;
   var
      user_len,user_cur:word;
      i:word;
   begin
      check_not_eoln;
      user_len:=check_word;
      check_eoln;
      for i:=1 to user_len do begin
         check_not_eoln;
         user_cur:=check_word;
      end;
      check_eof;
   end;

var
   x:array[1..15000]of word;
   n,maxlen:word;

   procedure input_data;
   var
      i:word;
   begin
      readln(n);
      for i:=1 to n do begin
         read(x[i]);
      end;
   end;

   procedure find_maxlen;
   var
      i,j:word;
      len:array[1..15000]of word;
   begin
      for i:=1 to n do begin
         maxlen:=0;
         for j:=1 to i-1 do begin
            if (x[j]<x[i])and(len[j]>maxlen) then
               maxlen:=len[j];
         end;
         len[i]:=maxlen+1;
      end;
      maxlen:=0;
      for i:=1 to n do begin
         if len[i]>maxlen then
            maxlen:=len[i];
      end;
   end;

   procedure check_answer;
   var
      user_len,user_cur,user_prev:word;
      found:boolean;
      i,j:word;
   begin
      readln(user_len);
      if user_len<>maxlen then
         wa;
      user_prev:=0;
      i:=0;
      for j:=1 to user_len do begin
         read(user_cur);
         if user_cur<=user_prev then
            wa;
         found:=false;
         for i:=i+1 to n do begin
            if x[i]=user_cur then begin
               found:=true;
               break;
            end;
         end;
         if not found then
            wa;
         user_prev:=user_cur;
      end;
   end;

begin
   assign(input,'incseq.in');
   reset(input);
   input_data;
   find_maxlen;
   assign(input,'incseq.out');
   reset(input);
   check_presentation;
   reset(input);
   check_answer;
   a;
end.