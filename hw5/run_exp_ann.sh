#!/bin/bash
#check CLI.java
java -Xmx5000m -jar target/assignment4-jabeja-1.0-jar-with-dependencies.jar -temp 2 -delta 0.01 -alpha 2 -simAnnhMode EXP $@
