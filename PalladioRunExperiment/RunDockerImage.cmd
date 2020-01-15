SET SRC_PATH=%cd%
REM SET IMAGE_NAME=thomasweber/palladioexperimentautomation:latest
SET IMAGE_NAME=palladioexperimentautomation:latest
SET CONTAINER_PATH=/usr
SET EXPERIMENT_FILE_NAME=Capacity.experiments
SET EXPERIMENT_GEN_FILE_NAME=Generated.experiments
SET EXPERIMENTS_FILE_DIR=/ExperimentData/model/Experiments/
SET EXPERIMENTS_FILE_DIR_WINDOWS=\ExperimentData\model\Experiments\
REM docker pull %IMAGE_NAME%
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