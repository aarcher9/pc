#!/bin/bash

jflex lexer.l
byaccj -J parser.y
javac Parser.java
java Parser
rm *.java
rm *.class

