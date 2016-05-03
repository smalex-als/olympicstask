#!/bin/bash

mvn install
JAR=`pwd`/target/ru.smalex.olympicstask-1.0-SNAPSHOT.jar
WD="incseq"
cd test/$WD
fpc CHECK.pas
for f in inp/*.in;
do
  cp $f $WD.in
  
  java -cp $JAR -DONLINE_JUDGE="true" \
    round01.Task1C < $WD.in > $WD.out
  res=`./CHECK`
  number=`echo $f | sed 's/[^0-9]*//g'`
  if [ "$res" == "a" ]; then
    echo "$number: OK"
  else
    echo "$number: fail"
  fi
done

