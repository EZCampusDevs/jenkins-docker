
## Jenkins-Docker

Since I plan on running the data scrape repo from Jenkins jobs, we need python. The easiest way to do that is build the docker image with python, so I figured, package it with alpine jenkins on alpine miniconda for a smaller image containing everything we need.

Hopefully we can now create new envs on the fly with this image, or do whatever we need.


[Jenkins Docker](https://hub.docker.com/_/jenkins/)

[Miniconda3 Docker](https://hub.docker.com/r/frolvlad/alpine-miniconda3/)

### Building

Clone the repo and run:
```sh
$ docker build -t jenkins_miniconda_alpine .
```

### Usage

Checking default python version:
```sh
$ docker run -it --rm jenkins_miniconda_alpine python -c 'import sys; print(sys.version)'

3.9.16 (main, Mar  8 2023, 14:00:05)
[GCC 11.2.0]
```

Setting up Jenkins:
```sh
docker run -p 127.0.0.1:8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home jenkins_miniconda_alpine
```
