#!perl -w

for($i=1;$i<=50;$i++){
   while(length $i<2){
      $i="0$i";
   }
   open FI,"<piggy.$i.in";
   $t=<FI>;
   chomp $t;
   ($e,$f)=split /\x20/,$t;
   $n=<FI>;
   chomp $n;
   print "$i ".$n*($f-$e)."\n";
}
