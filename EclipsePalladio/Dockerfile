FROM palladiosimulator/eclipse-modeling-tools
# Install everything from features.txt
COPY EclipsePalladio/InstallFeature.sh /usr/InstallFeature.sh
COPY EclipsePalladio/InstallLocalUpdates.sh /usr/InstallLocalUpdates.sh
COPY EclipsePalladio/features.txt usr/features.txt
RUN chmod a+rx usr/InstallLocalUpdates.sh
RUN chmod a+rx usr/InstallFeature.sh
RUN usr/InstallLocalUpdates.sh