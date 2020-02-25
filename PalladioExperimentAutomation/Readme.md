# Eclipse with installed palladiosimulator and files for ExperimentAutomation runs

## Description
Project extends my [eclipse palladio installation image](https://hub.docker.com/repository/docker/palladiosimulator/eclipsepalladio) with files to run ExperimentAutomation experiments. Also installs __xfvb__ and __libgtk-3-0__ because they are used during the experiment runs. Adds the scripts shown in the next sections to the image. The cmd script executes the experiment run.

## Usage
Simple docker image with a working headless eclipse installation. For an example how to use the application have a look at __EclipseExampleApplication__ as a folder in [this](https://github.com/TomWerm/Palladio-Docker) repository.

## Docker hub
The image can be found at [docker hub](https://hub.docker.com/repository/docker/palladiosimulator/palladioexperimentautomation).

## Dockerfile
``` bash
FROM palladiosimulator/eclipsepalladio
RUN apt-get clean && \
    apt-get update --fix-missing && \
    apt-get install -y --fix-missing xvfb libgtk-3-0
COPY RunExperimentAutomation.sh /usr/RunExperimentAutomation.sh
RUN chmod a+rx usr/RunExperimentAutomation.sh
COPY ModifyExperimentsFile.sh /usr/ModifyExperimentsFile.sh
RUN chmod a+rx usr/ModifyExperimentsFile.sh
```

## ModifyExperimentsFile.sh
- modifies the line with the datasource in the given file to export csv and add a valid location.

``` bash
#!/bin/bash
# modifies the file given with the first parameter and saves it to the file given with the second parameter
sed -E 's/<datasource [^>]*\/>/<datasource xsi:type=\"ExperimentAutomation.Experiments.AbstractSimulation:FileDatasource\" location=\"\/result\" exportOption=\"CSV\"\/>/' "$1" > "$2"
```
## RunExperimentAutomation.sh
``` bash
#!/bin/bash
# first argument is the path to the original experiments file, second is the path where to store the generated file
Xvfb :99 -screen 0 1920x1080x16 &
export DISPLAY=:99
/usr/ModifyExperimentsFile.sh "$1" "$2"
/usr/eclipse/eclipse \
     -clean \
     -application org.palladiosimulator.experimentautomation.application \
     -consoleLog "$2" \
     -data "/usr/workspace"
```

## RunDockerImage.cmd
- windows script to run the experiments in the annotated file and store the results at the current location
- change the paths to match your local folder structure
- can start a shell after the experiment is finished, i.e. to have a look at the log files
- executes the given experiment and saves the results in the folder \\Output

``` sh
SET SRC_PATH=%cd%
SET IMAGE_NAME=palladiosimulator/palladioexperimentautomation:latest
REM SET IMAGE_NAME=palladioexperimentautomation:latest
SET CONTAINER_PATH=/usr
SET EXPERIMENT_FILE_NAME=Capacity.experiments
SET EXPERIMENT_GEN_FILE_NAME=Generated.experiments
SET EXPERIMENTS_FILE_DIR=/ExperimentData/model/Experiments/
SET EXPERIMENTS_FILE_DIR_WINDOWS=\ExperimentData\model\Experiments\
docker pull %IMAGE_NAME%
docker run -it -d %IMAGE_NAME%
FOR /F "tokens=*" %%g IN ('docker ps -q') do (SET CONTAINER_ID=%%g)
FOR /F "tokens=*" %%g IN ('docker ps --format "{{.Names}}"') do (SET CONTAINER_NAME=%%g)
docker cp "%SRC_PATH%/ExperimentData" %CONTAINER_NAME%:/usr/ExperimentData
docker exec -it %CONTAINER_NAME% /usr/RunExperimentAutomation.sh %CONTAINER_PATH%%EXPERIMENTS_FILE_DIR%%EXPERIMENT_FILE_NAME% %CONTAINER_PATH%%EXPERIMENTS_FILE_DIR%%EXPERIMENT_GEN_FILE_NAME%
REM in case you need to do some other tasks after the experiment, uncomment the next line
docker exec -it %CONTAINER_NAME% bin/bash
docker cp %CONTAINER_NAME%:/result "%SRC_PATH%\Output"
docker stop %CONTAINER_ID%
DEL /f %SRC_PATH%%EXPERIMENTS_FILE_DIR_WINDOWS%%EXPERIMENT_GEN_FILE_NAME%
PAUSE
```
## Authors
[Thomas Weber](https://github.com/TomWerm)

## License
[![License](https://img.shields.io/badge/License-EPL%201.0-red.svg)](https://opensource.org/licenses/EPL-1.0)

## Project status
The project is finished.
