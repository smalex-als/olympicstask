#!/bin/bash

WD=$1

case $WD in
primes|1a)
  CLAZZ="round01.Task1A"
  WD="primes"
  ;;
expr|1b)
  CLAZZ="round01.Task1B"
  WD="expr"
  ;;
incseq|1c)
  CLAZZ="round01.Task1C"
  WD="incseq"
  ;;
power|1e)
  CLAZZ="round01.Task1E"
  WD="power"
  ;;
poker|1f)
  CLAZZ="round01.Task1F"
  WD="poker"
  ;;
primes2|2a)
  CLAZZ="round02.Task2A"
  WD="primes2"
  ;;
permut|2b)
  CLAZZ="round02.Task2B"
  WD="permut"
  ;;
route|2c)
  CLAZZ="round02.Task2C"
  WD="route"
  ;;
longsum|2e)
  CLAZZ="round02.Task2E"
  WD="longsum"
  ;;
spiral|2f)
  CLAZZ="round02.Task2F"
  WD="spiral"
  ;;
pfactor|3a)
  CLAZZ="round03.Task3A"
  WD="pfactor"
  ;;
permut2|3b)
  CLAZZ="round03.Task3B"
  WD="permut2"
  ;;
piggy|3c)
  CLAZZ="round03.Task3C"
  WD="piggy"
  ;;
longprod|3e)
  CLAZZ="round03.Task3E"
  WD="longprod"
  ;;
serpent|3f)
  CLAZZ="round03.Task3F"
  WD="serpent"
  ;;
*)
  echo "Test not found"
  exit
  ;;
esac


mvn install
JAR=`pwd`/target/ru.smalex.olympicstask-1.0-SNAPSHOT.jar
cd test/$WD
fpc CHECK.pas
for f in inp/*.in;
do
  cp $f $WD.in
  
  java -cp $JAR -DONLINE_JUDGE="true" \
    $CLAZZ < $WD.in > $WD.out
  res=`./CHECK`
  number=`echo $f | sed 's/[^0-9]*//g'`
  if [ "$res" == "a" ]; then
    echo "$number: OK"
  else
    echo "$number: fail"
  fi
done

rm CHECK CHECK.o $WD.out $WD.in

