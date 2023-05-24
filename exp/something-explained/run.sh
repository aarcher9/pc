#!/bin/bash
echo "Example from L2 infDyck"
echo "------------------------------"

jflex lexer.l
byaccj -J parser.y
javac Parser.java
java Parser
rm *.java
rm *.class