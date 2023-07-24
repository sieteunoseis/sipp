# Docker container for SIPp

- Docker container for running [SIPp](http://sipp.sourceforge.net/index.html)
- Builds version 3.7 from [Github ](https://github.com/SIPp)
- [Github Repo](https://github.com/sieteunoseis/sipp)
- [Docker Hub](https://hub.docker.com/r/sieteunoseis/sipp/)

https://github.com/pbertera/SIPp-by-example
https://github.com/saghul/sipp-scenarios
https://tomeko.net/other/sipp/sipp_cheatsheet.php?lang=en

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
$ docker run -it sieteunoseis/sipp -sn uac
```

If you want to use custom scenarios you can use the Docker VOLUME argument to include your local files inside your Docker image.  The `-v $PWD/scenarios` is your local hosts working directory and `/sipp` is the containers working directory.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060 sieteunoseis/sipp -sf uac.xml DEST_IP -s DEST_NUMBER
```
## Examples

### Active Media (UAC)

UAC scenario for Active media negotiation (SDP offer sent into the INVITE request).

The UAC is responsible for the dialog creation and closure.

Single call is made.

Audio is played from a pcap file.

Example shows a single call being made to DEST_IP with the destination number of DEST_NUMBER and the From header set to FROM_NUMBER.

```
$ sudo docker run -it -v $PWD/scenarios:/sipp -p 5060 sieteunoseis/sipp -sf uac-active.xml DEST_IP -s DEST_NUMBER -key tel FROM_NUMBER -m 1
```

### Passive Media (UAC)

UAC scenario for Passive media negotiation (SDP offer sent with the 200 OK).

The UAC is responsible for the dialog creation and closure.

Single call is made.

Audio is played from a pcap file.

```
$ sudo docker run -it -v $PWD/scenarios:/sipp -p 5060 sieteunoseis/sipp -sf uac-passive.xml DEST_IP -s DEST_NUMBER -m 1
```

### Hold (UAC)

UAC scenario for call hold using the RFC 3264 specification (a=sendonly/recvonly).

In this scenario the UAC sends the first INVITE, and the hold and retrieve re-INVITEs.

Single call is made.

Audio is played from a pcap file.

```
$ sudo docker run -it -v $PWD/scenarios:/sipp -p 5060 sieteunoseis/sipp -sf uac-hold.xml DEST_IP -s DEST_NUMBER -m 1
```

### FAX (UAC)

UAC scenario for sending a fax.

Single call is made.

Audio is played from a pcap file.

NOTE: This scenario is untested, Twilio does not support T.38.

```
$ sudo docker run -it -v $PWD/scenarios:/sipp -p 5060 sieteunoseis/sipp -sf uac-fax.xml DEST_IP -s DEST_NUMBER -m 1
```

### Call ID (UAC)

Set Call-ID header to a random UUID.

Assuming ```uuidgen``` is installed on your box you can use something like this:

```
$ docker run -it sieteunoseis/sipp uac DEST_IP -s DEST_NUMBER -cid_str $(uuidgen)@%s
```
Example:

```
...
Call-ID: 5d91975e-202d-44a6-b374-4171e64bb785
...
```
