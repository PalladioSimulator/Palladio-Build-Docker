FROM ubuntu:20.04
RUN apt-get clean && \
    apt-get update --fix-missing && \ 
    apt-get install -y --fix-missing openjdk-11-jre-headless wget
RUN /usr/bin/wget 'http://ftp.fau.de/eclipse/technology/epp/downloads/release/2019-12/R/eclipse-java-2019-12-R-linux-gtk-x86_64.tar.gz' && \
    tar -xzf eclipse-java-2019-12-R-linux-gtk-x86_64.tar.gz -C /usr && \
    rm eclipse-java-2019-12-R-linux-gtk-x86_64.tar.gz