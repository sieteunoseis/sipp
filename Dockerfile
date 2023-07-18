FROM ubuntu:latest as build
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y pkg-config dh-autoreconf ncurses-dev build-essential cmake libssl-dev libpcap-dev libncurses5-dev libsctp-dev lksctp-tools
ADD https://github.com/SIPp/sipp/releases/download/v3.6.1/sipp-3.6.1.tar.gz /
RUN tar -xzf /sipp-3.6.1.tar.gz
WORKDIR /sipp-3.6.1
RUN ./build.sh --full 

FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y libssl-dev libpcap-dev libncurses5-dev libsctp-dev
COPY --from=build /sipp-3.6.1/sipp /usr/local/bin/
WORKDIR /sipp

EXPOSE 5060

ENTRYPOINT ["sipp"]
