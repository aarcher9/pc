#!/bin/bash

jflex simple.l
byaccj -J simple.y
javac Parser.java
java Parser < src.s > compilato.txt
rm *.java
rm *.class

echo
./sm compilato.txt
