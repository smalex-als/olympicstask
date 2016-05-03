{
Written by Fyodor Menshikov 14.03.2002
15:56-16:00
on Intel Celeron 400:
function with immediate exit 2..500000 9s
Q-,R-,S-,I- <-> Q+,R+,S+,I+ 9s
cycle variable integer <-> longint 9s
w/o function 9s
w/o output 9s
downto cycle 48s
while cycle 23s
assembler 4s
only trunc(sqrt) <1s
asm function 2.900000 9s
I/O filename changed 12.01.2005
}
{$Q-,R-,S-,N+,E-}

   function isPrime(n:longint):boolean;
   var
      i:integer;
   begin
      isPrime:=false;
      for i:=2 to trunc(sqrt(n)) do
         if n mod i=0 then
            exit;
      isPrime:=true;
   end;

   function isPrimeAsm(n:longint):boolean;
   var
      truncsqrt:integer;
      answer:byte;
   begin
      truncsqrt:=trunc(sqrt(n));
      asm
         mov bx,truncsqrt
         mov cx,2
         mov answer,1
         mov si,word ptr n
         mov di,word ptr n+2
      @loop:
         cmp cx,bx
         jg @end
         xor dx,dx
         mov ax,di
         div cx
         mov ax,si
         div cx
         or dx,dx
         jz @wrong
         inc cx
         jmp @loop
      @wrong:
         mov answer,0
      @end:
      end;
      isPrimeAsm:=answer<>0;
   end;

var
   m,n,i,j:longint;
   no:boolean;
begin
   assign(input,'primes.in');
   reset(input);
   readln(m,n);
   close(input);
   assign(output,'primes.out');
   rewrite(output);
   no:=true;
   for i:=m to n do
      if isPrime(i) then begin
         writeln(i);
         no:=false;
      end;
   if no then
      writeln('Absent');
   close(output);
end.