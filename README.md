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
$ docker run -it sieteunoseis/sipp -sn uac
```
If you want to use custom scenarios you can use the Docker VOLUME argument to include your local files inside your Docker image.  The `-v $PWD/scenarios` is your local hosts working directory and `/sipp` is the containers working directory.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf XML_FILE
```

## Examples

### Basic UAC

Basic UAC scenario. The UAC is responsible for the dialog creation and closure. Single call is made with a 5 second pause between the INVITE and BYE.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uac.xml DEST_IP -s DEST_NUMBER -key tel FROM_NUMBER -key host_ip DOCKER_HOST_IP -m 1
```

### Active Media (UAC)

UAC scenario for Active media negotiation (SDP offer sent into the INVITE request).

The UAC is responsible for the dialog creation and closure.

Single call is made.

Audio is played from a pcap file for 90 seconds, before the call is terminated.

Example shows a single call being made to DEST_IP with the destination number of DEST_NUMBER and the From header set to FROM_NUMBER. The DOCKER_HOST_IP is the IP address of the Docker host.

Scenario options for g711a, g711u and g722 are included.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uac-active-g711a.xml DEST_IP -s DEST_NUMBER -key tel FROM_NUMBER -key host_ip DOCKER_HOST_IP -m 1
```

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uac-active-g711u.xml DEST_IP -s DEST_NUMBER -key tel FROM_NUMBER -key host_ip DOCKER_HOST_IP -m 1
```

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uac-active-g722.xml DEST_IP -s DEST_NUMBER -key tel FROM_NUMBER -key host_ip DOCKER_HOST_IP -m 1
```

#### Example with CSV file for multiple calls

Example shows 10 calls being made to DEST_IP with the destination number sourced from the CSV file and the From header set to FROM_NUMBER. The DOCKER_HOST_IP is the IP address of the Docker host.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uac-active-g711a-csv.xml -inf test-10.csv DEST_IP -key tel FROM_NUMBER -key host_ip DOCKER_HOST_IP -m 10
```

### Passive Media (UAC)

UAC scenario for Passive media negotiation (SDP offer sent with the 200 OK).

The UAC is responsible for the dialog creation and closure.

Single call is made.

Audio is played from a pcap file (g711a).

The DOCKER_HOST_IP is the IP address of the Docker host.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uac-passive.xml DEST_IP -s DEST_NUMBER -key host_ip DOCKER_HOST_IP -m 1
```

### Hold (UAC)

UAC scenario for call hold using the RFC 3264 specification (a=sendonly/recvonly).

In this scenario the UAC sends the first INVITE, and the hold and retrieve re-INVITEs.

Single call is made.

Audio is played from a pcap file.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uac-hold.xml DEST_IP -s DEST_NUMBER -key tel FROM_NUMBER -key host_ip DOCKER_HOST_IP -m 1
```

### DTMF (UAC)

UAC scenario for sending DTMF tones.

Single call is made.

DTMF tones are played from a pcap file(s).

NOTE: Tested with [Test Call](https://testcall.com/804-222-1111/). You can use this along with a packet capture to verify that the DTMF tones are being sent correctly. Test Call will play back audio of the DTMF tones that it receives.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uac-dtmf.xml DEST_IP -s DEST_NUMBER -key tel FROM_NUMBER -key host_ip DOCKER_HOST_IP -m 1
```

### OPTIONS (UAC)

UAC scenario for sending OPTIONS.

Single request is sent.

Useful to check if a firewall is blocking SIP traffic.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uac-options.xml DEST_IP -key host_ip DOCKER_HOST_IP -m 1
```

### OPTIONS (UAS)

UAS scenario for recieving OPTIONS.

Single request is sent.

Useful to check if a firewall is blocking SIP traffic.

```
$ docker run -it -v $PWD/scenarios:/sipp -p 5060:5060/udp sieteunoseis/sipp -sf uas-options.xml DEST_IP -key host_ip DOCKER_HOST_IP -m 1
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

### Adding additional ports to Docker Container

If you need to add additional ports to the Docker Container you can use the `-p` argument. This is usually required if you are using a scenario that requires RTP ports.

Example (Single Ports):

```
-p 5000:5000/udp -p 5001:5001/udp -p 5002:5002/udp
```

Example (Range of Ports):

```
-p 5000-6000:5000-6000/udp
```

Or you can expose the constainer to the host network instead of mapping ports. It allows the container greater network access than it can normally get.

```
--net=host
```


### Other Examples/Scenarios/Guides

- [SIPp-by-example](https://github.com/pbertera/SIPp-by-example)
- [sipp-scenarios](https://github.com/saghul/sipp-scenarios)
- [sipp-scenarios](https://github.com/ossobv/sipp-scenarios)
- [sipp/sipp_cheatsheet](https://tomeko.net/other/sipp/sipp_cheatsheet.php?lang=en)
- [sipp with Cisco CUCM](https://dmkravch.github.io/2018-01-21-sipp-with-cucm/)
- [Generating SIP traffic with SIPp (Video)](https://www.youtube.com/watch?v=Z3XQ3qZ3XqQ)
- [ctaloi/sipp](https://hub.docker.com/r/ctaloi/sipp)

### Cisco CUCM Configuration

#### Create a new SIP Trunk Security Profile. 

System > Security > SIP Trunk Security Profile.

Note: All above examples are using port 5060/UDP, which is why we are updating the port here.

![SIP Trunk Security Profile](https://github.com/sieteunoseis/sipp/blob/main/screenshots/sip-trunk-security-profile.png?raw=true)

#### Create a new SIP Profile.

Device > Device Settings > SIP Profile.

Here you can modify the SIP timers to match your SIPp scenario or update ports if required.

You can also enable/disable SIP OPTIONS ping. If you enable this you can use the UAS OPTIONS scenario above to test.

![SIP Profile Options](https://github.com/sieteunoseis/sipp/blob/main/screenshots/sip-profile-options.png?raw=true)

Media Ports

![SIP Profile Media Ports](https://github.com/sieteunoseis/sipp/blob/main/screenshots/sip-profile-media-ports.png?raw=true)

#### Create a new SIP Trunk.

Device > Trunk > Add New.

Set CSS for call permissions.

![SIP Trunk CSS](https://github.com/sieteunoseis/sipp/blob/main/screenshots/sip-trunk-inbound-css.png?raw=true)

Set SIP Information, including the SIP Trunk Security Profile and SIP Profile created above.

![Trunk SIP Information](https://github.com/sieteunoseis/sipp/blob/main/screenshots/sip-trunk-sip-information.png?raw=true)

#### Create Route Pattern for UAS scenarios.

Call Routing > Route/Hunt > Route Pattern.

![Route Pattern](https://github.com/sieteunoseis/sipp/blob/main/screenshots/route-pattern-sipp-uas.png?raw=true)

### Packet captures

Packet captures may be useful for troubleshooting, or validating SIPp scenarios. I've included some examples that I use in my testing below.

#### Ubuntu Linux (Docker Host)

```
tcpdump -s 0 -i ens160 -w sipp.pcap
```

#### Cisco vCube (ISR1000v)

```
Device>en
Device#config t
Device(config)#ip access-list extended PACKET_CAP_FILTER
Device(config)#10 permit ip any any
Device(config)#!
Device(config)#end
Device#monitor capture PACKET_CAP start
Device#monitor capture PACKET_CAP access-list PACKET_CAP_FILTER 	 
Device#monitor capture PACKET_CAP limit duration 1000
Device#monitor capture PACKET_CAP interface GigabitEthernet 1 both
Device#monitor capture PACKET_CAP buffer circular size 10
Device#monitor capture PACKET_CAP start
Device#monitor capture PACKET_CAP export tftp://192.168.1.100/sipp.pcap
Device#monitor capture PACKET_CAP stop
Device#monitor capture clear 
Captured data will be deleted [clear]?[confirm]
cleared buffer : PACKET_CAP
```

#### Cisco CUCM

Check out my article [Automating PCAP captures on Cisco VOS applications](https://medium.com/automate-builders/automating-pcap-captures-on-cisco-vos-applications-90d4b54588de) for a great example of how to capture SIP traffic on CUCM.

### Giving Back

If you would like to support my work and the time I put in creating the code, you can click the image below to get me a coffee. I would really appreciate it (but is not required).

<a href="https://www.buymeacoffee.com/automatebldrs" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>