#!/bin/sh

# Install docker and GIT
apt-get update
apt-get install docker.io git -y

# Get docker containers
docker pull jamescarscadden/vsts-agent-rails
docker pull postgres

# Run docker containers
docker run --name railsPostgres -e POSTGRES_PASSWORD=${1} -d postgres
docker run -it --link railsPostgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -c "CREATE ROLE agentUsr WITH LOGIN CREATEDB PASSWORD ${2}"'
docker run -t --name vstsagent --link railsPostgres \
    -e VSTS_CONFIG_USERNAME=${3} \
    -e VSTS_CONFIG_PASSWORD=${4} \
    -e VSTS_CONFIG_URL=${5} \
    -e VSTS_CONFIG_AGENTNAME=${6} \
    -d jamescarscadden/vsts-agent-rails
