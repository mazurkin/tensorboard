# Tensorboard control makefile
#
# https://swcarpentry.github.io/make-novice/reference.html
# https://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
# https://www.gnu.org/software/make/manual/make.html
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

SHELL := /bin/bash

DOCKER_NAME = tensorflow/tensorflow
DOCKER_TAG  = 2.16.1

TB_INSTANCE  ?= 0
TB_FOLDER    ?= /tmp/tensorboard/$(TB_INSTANCE)
TB_NAME      ?= tensorboard-$(TB_INSTANCE)
TB_PORT      ?= $$(( 6006 + $(TB_INSTANCE) ))

.DEFAULT_GOAL = docker-run

.PHONY: docker-run
docker-run:
	@echo "TB link      : http://localhost:$(TB_PORT)"
	@echo "TB instance  : $(TB_INSTANCE)"
	@echo "TB directory : $(TB_FOLDER)"
	@echo "TB name      : $(TB_NAME)"
	@echo "TB port      : $(TB_PORT)"
	@mkdir -p "$(TB_FOLDER)"
	@docker run \
		--name "$(TB_NAME)" \
		--hostname="$(TB_NAME)" \
		--rm \
		--interactive \
		--tty \
		--cpus 1 \
		--memory 512MB \
		--env "TF_ENABLE_ONEDNN_OPTS=0" \
		--volume "$(TB_FOLDER):/tmp/tensorboard:ro" \
		--publish "0.0.0.0:$(TB_PORT):6006/tcp" \
		$(DOCKER_NAME):$(DOCKER_TAG) \
			tensorboard \
				--port 6006 \
				--bind_all \
				--load_fast=false \
				--logdir "/tmp/tensorboard"
