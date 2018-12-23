#!/bin/bash
#check CLI.java
java -Xmx5000m -jar target/assignment4-jabeja-1.0-jar-with-dependencies.jar -temp 1 -delta 0.1 -alpha 2 -simAnnhMode EXP $@
