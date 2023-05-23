#!/bin/bash

jflex subst.l
javac Subst.java

echo "Running..."; echo
java Subst inputFile.txt
echo

rm *.java
rm *.class