#!/bin/bash

jflex simple.l
byaccj -J simple.y
javac Parser.java
java Parser < simple-test.s > compilato.txt
rm *.java
rm *.class

echo
./stack-machine compilato.txt
