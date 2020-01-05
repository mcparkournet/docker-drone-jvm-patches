# docker-drone-jvm-patches

Docker image used to build JVM applications based on Git patches in Drone CI environment.

## Components

This image has the following components:

* JVM (adoptopenjdk:13-jdk-openj9)
* Gradle (6.0.1)
* Maven (3.6.3)
* Git
* `patch`

## Usage

This image is available on [Docker Hub](https://hub.docker.com/r/mcparkour/docker-drone-jvm-patches). Simply set `image` to `mcparkour/docker-drone-jvm-patches:latest` in `.drone.yml` file and patch project.

```yml
kind: pipeline
type: docker
name: default

steps:
  - name: build
    image: mcparkour/docker-drone-jvm-patches:latest
    commands:
      - ./patches-manager.sh patch
```
