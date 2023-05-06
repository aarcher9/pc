#!/bin/bash

jflex main.l
javac Main.java

echo "Running..."
java Main input.txt
echo

rm *.java
rm *.class