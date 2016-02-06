.PHONY: all jar image

TAG?=0.2.0
ORG?=tombee
DEV_IMAGE_NAME?=spring-boot-app-dev
REPO?=$(ORG)/spring-boot-app

all: jar image

/var/run/docker.sock:
	$(error You must run your container with "-v /var/run/docker.sock:/var/run/docker.sock")

jar:
	@mvn package

image:
	@docker build --build-arg "VERSION=$$TAG" -t $(REPO):$(TAG) .
