#Dockerfile vars
APP_NAME = "netops"

#vars
IMAGEFULLNAME=${APP_NAME}

.PHONY: help build

help:
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "run"
	    @echo "all (default)"

.DEFAULT_GOAL := all

build:
		@docker build --pull -t ${IMAGEFULLNAME} .
		@docker scan ${IMAGEFULLNAME}

run:
		@docker run -it ${IMAGEFULLNAME}

all: build run
