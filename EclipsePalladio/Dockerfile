FROM palladiosimulator/eclipsemodelingtools
# Install everything from features.txt
COPY InstallFeature.sh /usr/InstallFeature.sh
COPY InstallLocalUpdates.sh /usr/InstallLocalUpdates.sh
COPY features.txt usr/features.txt
RUN chmod a+rx usr/InstallLocalUpdates.sh
RUN chmod a+rx usr/InstallFeature.sh
RUN usr/InstallLocalUpdates.sh