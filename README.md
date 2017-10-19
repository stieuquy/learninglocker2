# Learning Locker version 2 in Docker

It is a dockerized version of Learning Locker (LL) version 2 based on the installation guides at http://docs.learninglocker.net/guides-custom-installation/

## Architecture

For LL's architecture consult http://docs.learninglocker.net/overview-architecture/

This section is about the architecture coming out of this dockerization.

Official images of Mongo, Redis, and xAPI service are used.
Additionally, build creates two Docker images: nginx and app. 
LL application services are to be run on containers based on the app image. 

File docker-compose.yml describes the relation between services. 
A base configuration consists of 7 containers that are run using the above-mentioned images 
(LL application containers - api, ui, and worker - are run using image app).

The only persistent data is Mongo's volume.

The origin service ui expects service api to work on localhost, 
however in this dockerized version the both services are run in separate containers. 
To make connections between those services work, socat process is run within ui container to forward local tcp connections to api container.

## Usage

To build the images:

```
./build-dev.sh
```

To configure adjust settings in .env:

* DOCKER_TAG - git commit (SHA-1) to be used ("dev" for images built by build-dev.sh)
* DATA_LOCATION - location on Docker host where volumes are created
* DOMAIN_NAME - domain name as the instance is to be accessed from the world
* APP_SECRET - LL's origin setting: Unique string used for hashing, Recommended length - 256 bits

To run the services:

```
docker-compose up
```

Open the site and accept non-trusted SSL/TLS certs (see below for trusted certs).

To create a new user and organisation for the site:

```
docker-compose exec api node cli/dist/server createSiteAdmin [email] [organisation] [password]
```

## Deploy

TODO

## Production usage

### SSL/TLS certs

Mount cert files to nginx container adding a section in docker-compose.yml:

```
     volumes:
        - "/path-to-certs-on-docker-host/fullchain.pem:/root/ssl/fullchain.pem:ro"
        - "/path-to-certs-on-docker-host/privkey.pem:/root/ssl/privkey.pem:ro"
```

### Backups

Backup Mongo's volume.

## Futher adjustments

In app/Dockerfile, git tag of LL application is declared.
In docker-compose.yml, image tag of xAPI service is declared.
The versions (tags) in use can be easily adjusted as needed.
