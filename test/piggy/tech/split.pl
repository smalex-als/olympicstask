#!perl -w

open FI,"<pig.in.gz";
open FO,"<pig.out.gz";
$cases=<FI>;
chomp $cases;
for($i=1;$i<=$cases;$i++){
   while(length $i<2){
      $i="0$i";
   }
   print "$i\n";
   open FII,">piggy.$i.in";
   $t=<FI>;
   chomp $t;
   ($e,$f)=split /\x20/,$t;
   print FII "$e $f\n";
   $n=<FI>;
   chomp $n;
   print FII "$n\n";
   for($j=1;$j<=$n;$j++){
      $t=<FI>;
      print FII "$t";
   }
   close FII;
   open FOO,">piggy.$i.out";
   $t=<FO>;
   print FOO "$t";
   close FOO;
}
