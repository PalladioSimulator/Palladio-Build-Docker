FROM palladiosimulator/eclipsepalladio
RUN apt-get clean && \
    apt-get update --fix-missing && \ 
    apt-get install -y --fix-missing xvfb libgtk-3-0
COPY RunExperimentAutomation.sh /usr/RunExperimentAutomation.sh
RUN chmod a+rx usr/RunExperimentAutomation.sh
COPY ModifyExperimentsFile.sh /usr/ModifyExperimentsFile.sh
RUN chmod a+rx usr/ModifyExperimentsFile.sh