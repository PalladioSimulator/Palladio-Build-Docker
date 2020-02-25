FROM palladiosimulator/eclipse
COPY RunApplication.sh /usr/RunApplication.sh
RUN chmod a+rx usr/RunApplication.sh
COPY edu.kit.sdq.exampleapplication_1.0.0.202002111755.jar /usr/eclipse/dropins/plugins/edu.kit.sdq.exampleapplication_1.0.0.202002111755.jar
RUN /usr/RunApplication.sh