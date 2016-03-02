#!/bin/sh

args=("$@")

# Install docker and GIT
apt-get update
apt-get install docker.io git -y

# Get docker containers
docker pull jamescarscadden/vsts-agent-rails
docker pull postgres

# Run docker containers
docker run --name railsPostgres -e POSTGRES_PASSWORD=${args[0]} -d postgres
docker run -it --link railsPostgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -c "CREATE ROLE agentUsr WITH LOGIN CREATEDB PASSWORD ${args[1]}"'
docker run -t --name vstsagent --link railsPostgres \
    -e VSTS_CONFIG_USERNAME=${args[2]} \
    -e VSTS_CONFIG_PASSWORD=${args[3]} \
    -e VSTS_CONFIG_URL=${args[4]} \
    -e VSTS_CONFIG_AGENTNAME=${args[5]} \
    -d jamescarscadden/vsts-agent-rails
