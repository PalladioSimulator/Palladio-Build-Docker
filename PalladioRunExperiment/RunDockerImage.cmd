SET SRC_PATH=%cd%
SET IMAGE_NAME=palladiosimulator/palladioexperimentautomation:latest
SET CONTAINER_PATH=/usr
SET EXPERIMENT_FILE_NAME=Capacity.experiments
SET EXPERIMENT_GEN_FILE_NAME=Generated.experiments
SET EXPERIMENTS_FILE_DIR=/ExperimentData/model/Experiments/
docker pull %IMAGE_NAME%
docker run -d --mount source="%SRC_PATH%\Output",target=%IMAGE_NAME%:/result --mount source="%SRC_PATH%\ExperimentData",target=%IMAGE_NAME%:/usr/ExperimentData %IMAGE_NAME% /usr/RunExperimentAutomation.sh %CONTAINER_PATH%%EXPERIMENTS_FILE_DIR%%EXPERIMENT_FILE_NAME% %CONTAINER_PATH%%EXPERIMENTS_FILE_DIR%%EXPERIMENT_GEN_FILE_NAME%
PAUSE