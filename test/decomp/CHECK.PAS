{
Written by Fyodor Menshikov 01.04.2002
20:21-20:28
Modified into checker 22.12.2003
I/O filename changed 07.01.2004
I/O filename changed 12.01.2005
}
{-$R+,Q+,S+}
{-$define debug}
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

var
   n:integer;{2..40!!!}
const
   maxdiff=8;{1+2+3+4+5+6+7+8=36 <= 40 < 45=1+2+3+4+5+6+7+8+9}
type
   tdata=record
      value:array[1..maxdiff]of byte;
      count:array[1..maxdiff]of byte;
   end;
   tpacked=record
      value1:byte;
      value:array[2..maxdiff]of byte;
      count:array[2..maxdiff]of byte;
   end;

   procedure initdata(var d:tdata);
   var
      i:integer;
   begin
      for i:=1 to maxdiff do begin
         d.value[i]:=0;
         d.count[i]:=0;
      end;
   end;

   procedure pack(d:tdata;var p:tpacked);
   var
      i:integer;
   begin
      p.value1:=d.value[1];
      for i:=2 to maxdiff do begin
         p.value[i]:=d.value[i];
         p.count[i]:=d.count[i];
      end;
   end;

   procedure unpack(p:tpacked;var d:tdata);
   var
      i,s:integer;
   begin
      s:=0;
      for i:=2 to maxdiff do begin
         d.value[i]:=p.value[i];
         d.count[i]:=p.count[i];
         s:=s+p.value[i]*p.count[i];
      end;
      d.value[1]:=p.value1;
      d.count[1]:=(n-s) div p.value1;
   end;

   function cmp(d1,d2:tdata):integer;
   var
      i:integer;
   begin
      for i:=1 to maxdiff do begin
         if d1.value[i]<d2.value[i] then begin
            cmp:=-1;
            exit;
         end;
         if d1.value[i]>d2.value[i] then begin
            cmp:=1;
            exit;
         end;
         if d1.count[i]<d2.count[i] then begin
            cmp:=-1;
            exit;
         end;
         if d1.count[i]>d2.count[i] then begin
            cmp:=1;
            exit;
         end;
      end;
      cmp:=0;
   end;

   procedure addvalue(var d:tdata;v:byte);
   var
      i:integer;
   begin
      for i:=1 to maxdiff do
         if d.value[i]=v then begin
            inc(d.count[i]);
            exit;
         end;
      for i:=1 to maxdiff do
         if d.count[i]=0 then begin
            d.value[i]:=v;
            d.count[i]:=1;
            exit;
         end;
      ie('addvalue');
   end;

   procedure normdata(var d:tdata);
   var
      i,j:integer;
      buf:byte;
   begin
      for i:=1 to maxdiff do
         for j:=1 to maxdiff do
            if (i<j)and(d.value[i]<d.value[j]) then begin
               buf:=d.value[i];
               d.value[i]:=d.value[j];
               d.value[j]:=buf;
               buf:=d.count[i];
               d.count[i]:=d.count[j];
               d.count[j]:=buf;
            end;
   end;

   procedure showdata(var d:tdata);
   var
      i,j:integer;
   begin
      write(d.value[1]);
      for j:=2 to d.count[1] do
         write('+',d.value[1]);
      for i:=2 to maxdiff do
         if d.count[i]<>0 then
            for j:=1 to d.count[i] do
               write('+',d.value[i]);
      writeln;
   end;

const
   alen=3800;{answer for N=40 is 37337 lines}
type
   packedarray=array[0..alen-1]of tpacked;
var
   lines:array[0..9]of ^packedarray;

   procedure inittable;
   var
      i:integer;
   begin
      for i:=0 to 9 do
         new(lines[i]);
   end;

   procedure put(index:longint;d:tdata);
   var
      p:tpacked;
   begin
      pack(d,p);
      lines[index div alen]^[index mod alen]:=p;
   end;

   procedure get(index:longint;var d:tdata);
   var
      p:tpacked;
   begin
      p:=lines[index div alen]^[index mod alen];
      unpack(p,d);
   end;

var
   c:char;

   procedure nextchar;
   begin
      if eoln then begin
         c:=#13;
         {$ifdef debug}writeln;{$endif}
      end
      else begin
         read(c);
         {$ifdef debug}write(c);{$endif}
      end;
   end;

   procedure parsenum(var num:integer);
   begin
      if c='0' then begin
         num:=0;
         nextchar;
      end
      else if c in['1'..'9'] then begin
         num:=0;
         repeat
            num:=num*10+ord(c)-ord('0');
            nextchar;
            if num>=n then
               pe;
         until not (c in ['0'..'9']);
      end
      else
         pe;
   end;

   procedure parseline(var d:tdata);
   var
      num:integer;
      s:integer;
   begin
      s:=0;
      c:='+';
      initdata(d);
      while c='+' do begin
         nextchar;
         parsenum(num);
         s:=s+num;
         if s>n then
            pe;
         addvalue(d,num);
      end;
      if c<>#13 then
         pe;
      if s<>n then
         pe;
      normdata(d);
      readln;
   end;

   procedure sort(l,r:longint);
   var
      i,j:longint;
      ti,tj,key:tdata;
   begin
      get((l+r)div 2,key);
      i:=l;
      j:=r;
      repeat
         while true do begin
            get(i,ti);
            if cmp(ti,key)<0 then
               inc(i)
            else
               break;
         end;
         while true do begin
            get(j,tj);
            if cmp(key,tj)<0 then
               dec(j)
            else
               break;
         end;
         if i<=j then begin
            get(i,ti);
            get(j,tj);
            put(i,tj);
            put(j,ti);
            inc(i);
            dec(j);
         end;
      until i>j;
      if l<j then
         sort(l,j);
      if i<r then
         sort(i,r);
   end;

var
   countjudge,countuser:longint;

   procedure showtable;
   var
      i:longint;
      d:tdata;
   begin
      for i:=0 to countuser-1 do begin
         get(i,d);
         showdata(d);
      end;
   end;

   procedure recurse(step,start,left:integer);
   var
      i:integer;
   begin
      if start>left then
         exit;
      if step>1 then
         inc(countjudge);
      for i:=start to left do
         recurse(step+1,i,left-i);
   end;

var
   d,prevd:tdata;
   i:longint;
begin
   assign(input,'decomp.in');
   reset(input);
   readln(n);
   if (n<2) or (n>40) then
      ie('n is not in [2..40]');
   countjudge:=0;
   recurse(1,1,n);
   assign(input,'decomp.out');
   reset(input);
   inittable;
   countuser:=0;
   while not eof do begin
      parseline(d);
      if countuser<countjudge then
         put(countuser,d);
      inc(countuser);
   end;

   {$ifdef debug}writeln('syntax ok');{$endif}
   if countuser<>countjudge then
      wa;
   
   {$ifdef debug}showtable;{$endif}
   {$ifdef debug}writeln('sorting...');{$endif}

   sort(0,countuser-1);
   
   {$ifdef debug}writeln('sorted');{$endif}
   {$ifdef debug}showtable;{$endif}

   get(0,d);
   for i:=1 to countuser-1 do begin
      prevd:=d;
      get(i,d);
      case cmp(prevd,d) of
      -1:{ok};
      0:wa;
      1:ie('not sorted');
      else
         ie('cmp bug');
      end;
   end;
   ac;
end.