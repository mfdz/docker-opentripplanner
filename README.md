OpenTripPlanner Docker image
============================

This project contains a Docker image for [MFDZ's 
OpenTripPlanner](http://opentripplanner.org). It is available from
Docker Hub in the
[`mfdz/opentripplanner` repository](https://hub.docker.com/r/mfdz/opentripplanner/).
The `latest` tag points to the latest MFDZ release.

## Usage

The `otp` command is available as a shortcut for `java -jar otp.jar`:

    docker run \
        -e JAVA_MX=2G \
        -v $PWD:/data:ro \
        -p 8080:8080 \
        mfdz/opentripplanner:latest \
        otp --build /data --inMemory

After the graph has been built, the planner is available at port 8080.

### Environment variables

**JAVA_MX**: The amount of heap space available to OpenTripPlanner. (The `otp`
             command adds `-Xmx$JAVA_MX` to the `java` command.) Default: 1G

## Building an image
To build an image, use

	docker build -t mfdz/opentripplanner .

To build from other github repositories/branches, you may specifiy build arguments like e.g.

	docker build --build-arg BRANCH=ridesharing --build-arg REPO=mfdz -t mfdz/opentripplanner . 

### Build arguments

**BRANCH**: The branch which is used to perform the build. Default: ridesharing

**REPO**: The repo which is used to checkout the sources from. Default: mfdz
