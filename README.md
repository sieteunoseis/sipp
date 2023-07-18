# Docker container for SIPp

- Docker container for running [SIPp](http://sipp.sourceforge.net/index.html)
- Builds version 3.6 from [Github ](https://github.com/SIPp)
- [Github Repo](https://github.com/ciscomonkey/sipp-docker)
- [Docker Hub](https://hub.docker.com/r/ciscomonkey/sipp/)

## Getting Started

Pull the latest image using:

```
$ docker pull ciscomonkey/sipp
$ docker run -it ciscomonkey/sipp
```

or clone this repo and

```
$ docker build -t sipp .
$ docker run -it sipp
```

## Usage

You can pass your SIPp arguments to the run command, example:

```
$ docker run -it sipp -sn uac
```

If you want to use custom scenarios you can use the Docker VOLUME argument to include your local files inside your Docker image.  The `-v $PWD/scenarios` is your local hosts working directory and `/sipp` is the containers working directory.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060 sipp -sf opt1.xml DEST_IP -s DEST_NUMBER
```

## Call ID

Assuming ```uuidgen``` is installed on your box you can use something like this:

```
$ docker run -it ciscomonkey/sipp uac 127.0.0.1 -s DEST_NUMBER -cid_str $(uuidgen)@%s
```
