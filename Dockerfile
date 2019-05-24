FROM maven:3-jdk-8

# Credits to Go About (https://github.com/goabout/docker-opentripplanner/) for the original docker file
# Note: Build with the local repo mounted, otherwise container will be bloated as .m2 is not deleted:
MAINTAINER Holger Bruch <holger.bruch@mitfahrdezentrale.de>
ARG REPO=mfdz
ARG BRANCH=ridesharing
ENV REPO=${REPO} \
    BRANCH=${BRANCH} \
    JAVA_MX=1G

RUN mkdir /tmp/build && \
    cd /tmp/build && \
    wget -O src.zip https://github.com/$REPO/OpenTripPlanner/archive/$BRANCH.zip && \
    unzip src.zip && \
    cd OpenTripPlanner-$BRANCH && \
    mvn package -DskipTests && \
    mkdir -p /usr/local/share/java && \
    mv target/otp-*shaded.jar /usr/local/share/java/otp.jar && \
    rm -r /tmp/build ~/.m2/repository &&\
	echo "Built on $(date +%Y-%m-%d)"

COPY otp /usr/local/bin/
RUN chmod 755 /usr/local/bin/*

EXPOSE 8080
# To mount external folder supply -v /path/on/host:/var/otp to docker run
VOLUME /var/otp