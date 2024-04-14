################################################################################
# Envs
################################################################################

CURRENT_DIRECTORY := $(shell pwd)
DOCKER_EXEC := docker compose exec app
GLOBIGNORE=.keep

################################################################################
# Local
################################################################################
# sudo chown -R ${USER}:${USER} .

clean:
	rm -rf ./coverage ./tmp/* ./log/* ./storage/*

dbrenew:
	make clean
	bundle exec rails db:drop db:create db:schema:load db:test:prepare db:seed
	bundle exec rails db:environment:set RAILS_ENV=development

################################################################################
# Docker
################################################################################

dk-bash:
	${DOCKER_EXEC} bash

dk-console:
	${DOCKER_EXEC} bundle exec rails c

dk-rspec:
	${DOCKER_EXEC} bundle exec rspec

dk-rubocop:
	${DOCKER_EXEC} bundle exec rubocop

dk-dbrenew:
	${DOCKER_EXEC} make dbrenew

dk-clean:
	${DOCKER_EXEC} make clean
