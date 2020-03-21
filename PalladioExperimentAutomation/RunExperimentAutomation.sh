#!/bin/bash
# first argument is the path to the original experiments file, second is the path where to store the generated file
Xvfb :99 -screen 0 1920x1080x16 &
export DISPLAY=:99
/usr/ModifyExperimentsFile.sh "$1" "$2"
/result/eclipse/eclipse \
     -clean \
     -application org.palladiosimulator.experimentautomation.application \
     -consoleLog "$2" \
     -data "/result/workspace"
