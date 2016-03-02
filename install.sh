#!/bin/sh

# Install docker and GIT
apt-get update
apt-get install docker.io git -y

# Get docker containers
docker pull jamescarscadden/vsts-agent-rails
docker pull postgres

# Run postgres docker container
docker run --name railsPostgres -e POSTGRES_PASSWORD=${1} -d postgres

# Create an agent user in postgres
pass="PASSWORD '${2}'"
conn="postgresql://postgres:${1}@railsPostgres:5432"
docker run -i --link railsPostgres:postgres --rm postgres sh -c 'exec psql $conn -c "CREATE ROLE agentUsr WITH LOGIN CREATEDB $pass;"'

# Run agent docker container
docker run -i --name vstsagent --link railsPostgres:postgres \
    -e VSTS_CONFIG_USERNAME=${3} \
    -e VSTS_CONFIG_PASSWORD=${4} \
    -e VSTS_CONFIG_URL=${5} \
    -e VSTS_CONFIG_AGENTNAME=${6} \
    -d jamescarscadden/vsts-agent-rails
