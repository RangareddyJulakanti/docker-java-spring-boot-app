# Using Docker with your spring-boot application

This is a simple spring-boot application that is both built and executed using Docker.

By building and testing our applications in Docker containers, we can be sure that we have isolated our build environment from external dependency and configuration changes.  These dependencies remain inside the container, and are never installed directly on the build host.  This is advantangeous when running many different builds on a CI server, and not wanting to pollute hosts with many different (and potentially conflicting!) build dependencies.  It's also useful for developers who work on many different components that also require different dependencies for build configuration.

This setup creates a lightweight runtime container that is based on `alpine:3.3`, that only contains an JRE 8 install and our built jar.

## Usage

```shell
$ ./script/run make
$ docker run --rm -p 8080:8080 -it tombee/spring-boot-app:0.2.0
```

## How does it work?

### `Dockerfile.build`

The `Dockerfile.build` describes the full build/test environment that is required for this java application.  It is based on `maven`, since the spring-boot application requires maven for itsbuild and test.  It includes the `docker` binary to allow this container to construct our runtime image.

### `Dockerfile`

The `Dockerfile` describes our lightweight runtime container, it should contain only the minimum set of files for our application to run.  At the moment, this produces a container that is approximately 139.4 MB.

### `Makefile`

The `Makefile` provides a series of targets to record the commonly executed commands to build the jar file and create the Docker image.  There are some variables in here to control the naming of the image produced, and the version number.  This Makefile can be further extended to suit your release process if an image needs to be pushed to Docker Hub or a private registry.

### `script/run`

This is a helper script to run our build environment container, it accepts parameters that you wish to run inside the container.  Given `./script/run make`, it will build the jar file and create a runtime docker image.

As an optimisation, it breaks filesystem isolation by volume mounting `~/.m2` onto the host's filesystem.  This helps to make incremental builds faster, this can be safely removed if this behaviour is unwanted.
