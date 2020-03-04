#!/bin/bash
# modifies the file given with the first parameter and saves it to the file given with the second parameter
sed -E 's/<datasource [^>]*\/>/<datasource xsi:type=\"ExperimentAutomation.Experiments.AbstractSimulation:FileDatasource\" location=\"\/wksp_eclipse/result\" exportOption=\"CSV\"\/>/' "$1" > "$2"
