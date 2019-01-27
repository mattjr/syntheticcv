FROM ubuntu:14.04

#Install git
RUN apt-get update \
    && apt-get install -y git python-pip wget

RUN git clone https://github.com/mattjr/syntheticcv.git

RUN cd syntheticcv && sh install.sh
