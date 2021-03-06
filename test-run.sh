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
decomp|4b)
  CLAZZ="round04.Task4B"
  WD="decomp"
  ;;
gangster|4c)
  CLAZZ="round04.Task4C"
  WD="gangster"
  ;;
divshort|4e)
  CLAZZ="round04.Task4E"
  WD="divshort"
  ;;
bracket|4f)
  CLAZZ="round04.Task4F"
  WD="bracket"
  ;;
friendly|5a)
  CLAZZ="round05.Task5A"
  WD="friendly"
  ;;
bracket2|5b)
  CLAZZ="round05.Task5B"
  WD="bracket2"
  ;;
route2|5c)
  CLAZZ="round05.Task5C"
  WD="route2"
  ;;
scale|5e)
  CLAZZ="round05.Task5E"
  WD="scale"
  ;;
cover|6a)
  CLAZZ="round06.Task6A"
  WD="cover"
  ;;
sums|6b)
  CLAZZ="round06.Task6B"
  WD="sums"
  ;;
lines|6e)
  CLAZZ="round06.Task6E"
  WD="lines"
  ;;
paintlab|6f)
  CLAZZ="round06.Task6F"
  WD="paintlab"
  ;;
*)
  echo "Test not found"
  exit
  ;;
esac


mvn install
JAR=`pwd`/target/ru.smalex.olympicstask-1.0-SNAPSHOT.jar
cd test/$WD
if [ -f CHECK.pas ]; then
  fpc CHECK.pas
fi
for f in inp/*.in;
do
  cp $f $WD.in
  
  java -cp $JAR -DONLINE_JUDGE="true" \
    $CLAZZ < $WD.in > $WD.out
  if [ -f CHECK.pas ]; then
    res=`./CHECK`
    number=`echo $f | sed 's/[^0-9]*//g'`
    if [ "$res" == "a" ]; then
      echo "$number: OK"
    else
      echo "$number: fail"
    fi
  else
    number=`echo $f | sed 's/[^0-9]*//g'`
    diff -b -B $WD.out out/$WD.$number.out
    if [ $? -eq 0 ]; then
      echo "$number: OK"
    else
      echo "$number: fail"
    fi
  fi
done

if [ -f CHECK ]; then
  rm CHECK
fi
if [ -f CHECK.o ]; then
  rm CHECK.o
fi
rm $WD.out $WD.in

