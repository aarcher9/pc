#!/bin/bash

jflex lexer.l
byaccj -J parser.y
javac Parser.java
java Parser > ouput.txt
rm *.java
rm *.class

