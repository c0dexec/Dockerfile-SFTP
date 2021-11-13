# Creating SFTP using Docker
I first created a Dockerfile which created a image for my SFTP server. Then to deploy the following image I made use of docker-compose.yml.

## Dockerfile 
I created a Dockerfile for a SFTP server for practice, in order to familarize myself with Dockerfiles.

For the ease of use add your public keys for hosts that you want to get password-less SFTP sessions setup for.
### Docker Build
```docker build -t sftp:1 .```

## docker-compose.yml
Made use of docker-compose to learn how to make use of a locally build image.
### Docker Compose
```docker-compose up -d```