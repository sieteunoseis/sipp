# Docker container for SIPp

- Docker container for running [SIPp](http://sipp.sourceforge.net/index.html)
- Builds version 3.7 from [Github ](https://github.com/SIPp)
- [Github Repo](https://github.com/sieteunoseis/sipp)
- [Docker Hub](https://hub.docker.com/r/sieteunoseis/sipp/)

## Getting Started

Pull the latest image using:

```
$ docker pull sieteunoseis/sipp
$ docker run -it sieteunoseis/sipp
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
$ docker run -it -v $PWD/scenarios:/sipp -p 5060 sieteunoseis/sipp -sf uac.xml DEST_IP -s DEST_NUMBER -m 1
```

## Call ID

Assuming ```uuidgen``` is installed on your box you can use something like this:

```
$ docker run -it sieteunoseis/sipp uac DEST_IP -s DEST_NUMBER -cid_str $(uuidgen)@%s
```
Example:

```
...
Call-ID: 5d91975e-202d-44a6-b374-4171e64bb785@172.17.0.8
...
```
