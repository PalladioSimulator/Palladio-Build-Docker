# Eclipse with installed palladiosimulator

## Description
Project extends my [eclipse modeling tools image](https://hub.docker.com/repository/docker/palladiosimulator/eclipsemodelingtools). Installs all packages named in features.txt from the given update sites. The format of the file is:
``` bash
# comment lines
org.feature1,org.feature2%updatesite1,updatesite2
```
The plug-ins are installed in the order the occur in this file. The current state of the file (11.02.2020) is:
``` bash
#package1,package2,etc%updatesite1,updatesite2,etc
#currently all packages needed to run the palladio experiment automation
org.palladiosimulator.edp2.feature.feature.group,org.palladiosimulator.pcm.feature.feature.group,org.palladiosimulator.simucom.feature.feature.group,org.palladiosimulator.solver.feature.feature.group,org.palladiosimulator.recorderframework.feature.feature.group,org.palladiosimulator.analyzer.feature.feature.group,org.palladiosimulator.monitorrepository.feature.feature.group,org.palladiosimulator.simulizar.feature.feature.group,org.palladiosimulator.simulation.abstractsimengine.desmoj.feature.feature.group%https://updatesite.palladio-simulator.com/palladio-build-updatesite/releases/4.2.0/
# comment this line and uncomment the following one to add the export function in the nightly release
# add the feature back to the list above once a new release with export is available
org.palladiosimulator.experimentautomation.application.feature.feature.group,org.palladiosimulator.experimentautomation.feature.feature.group,org.palladiosimulator.experimentautomation.application.tooladapter.simulizar.feature.feature.group%https://updatesite.palladio-simulator.com/palladio-addons-experimentautomation/branches/csvExportRelease/,https://updatesite.palladio-simulator.com/palladio-build-updatesite/releases/4.2.0/
# org.palladiosimulator.experimentautomation.application.feature.feature.group%https://updatesite.palladio-simulator.com/palladio-build-updatesite/releases/nightly/
```

## Usage
Simple docker image with a working headless eclipse and palladio installation. For an example how to use the application have a look at __PalladioExperimentAutomation__ as a folder in [this](https://github.com/TomWerm/Palladio-Docker) repository.

## Docker hub
The image can be found at [docker hub](https://hub.docker.com/repository/docker/palladiosimulator/eclipsepalladio).

## Dockerfile
- probably you have to add basic update sites that cannot be located during the installation process
``` bash
FROM palladiosimulator/eclipse-modeling-tools
# Install everything from features.txt
COPY InstallFeature.sh /usr/InstallFeature.sh
COPY InstallLocalUpdates.sh /usr/InstallLocalUpdates.sh
COPY features.txt usr/features.txt
RUN chmod a+rx usr/InstallLocalUpdates.sh
RUN chmod a+rx usr/InstallFeature.sh
RUN usr/InstallLocalUpdates.sh
```

## Scripts
### InstallFeature.sh
- installs the given features from the given update sites
- the basic update site for the 2019-12 release is already added
``` bash
echo installing "$1"
echo from server "$2"
/usr/eclipse/eclipse \
    -application org.eclipse.equinox.p2.director \
    -repository https://download.eclipse.org/releases/2019-12/,"$2" \
    -installIU "$1"
```

### InstallLocalUpdates.sh
- piping every 2 arguments of the input in the InstallFeature script
``` bash
sed '/^#/ d' /usr/features.txt | sed 's/\([^%]*\)%\([^%]*\)/ "\1" "\2"/' | xargs -r -n 2 /usr/InstallFeature.sh
```
## Authors
[Thomas Weber](https://github.com/TomWerm)

## License
[![License](https://img.shields.io/badge/License-EPL%201.0-red.svg)](https://opensource.org/licenses/EPL-1.0)

## Project status
The project is finished.
