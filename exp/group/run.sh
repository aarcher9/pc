#!/bin/bash

byaccj -J group.y
javac Parser.java

echo "Running..."; echo
java Parser
echo

rm *.java
rm *.class