FROM palladiosimulator/eclipse-palladio
RUN apt-get clean && \
    apt-get update --fix-missing && \ 
    apt-get install -y --fix-missing xvfb libgtk-3-0
COPY PalladioExperimentAutomation/RunExperimentAutomation.sh /usr/RunExperimentAutomation.sh
RUN chmod a+rx usr/RunExperimentAutomation.sh
COPY PalladioExperimentAutomation/ModifyExperimentsFile.sh /usr/ModifyExperimentsFile.sh
RUN chmod a+rx usr/ModifyExperimentsFile.sh
