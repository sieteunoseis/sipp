FROM ubuntu:latest as build

LABEL "author"="github.com/sieteunoseis"
LABEL "system"="ubuntu:latest"
LABEL "version"="SIPp v3.7.2"
LABEL "description"="SIPP with sctp, pcap and openssl support"

ARG SIPP_VERSION=3.7.2

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y pkg-config dh-autoreconf ncurses-dev build-essential cmake libssl-dev libpcap-dev libncurses5-dev libsctp-dev lksctp-tools
ADD https://github.com/SIPp/sipp/releases/download/v${SIPP_VERSION}/sipp-${SIPP_VERSION}.tar.gz /
RUN tar -xzf /sipp-${SIPP_VERSION}.tar.gz
WORKDIR /sipp-${SIPP_VERSION}
RUN cmake . -DUSE_SSL=1 -DUSE_SCTP=1 -DUSE_PCAP=1 -DUSE_GSL=1
RUN make all

FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y libssl-dev libpcap-dev libncurses5-dev libsctp-dev
COPY --from=build /sipp-3.7.2/sipp /usr/local/bin/
WORKDIR /sipp

EXPOSE 5060

ENTRYPOINT ["sipp"]
