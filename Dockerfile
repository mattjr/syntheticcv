FROM ubuntu:14.04

#Install git
RUN apt-get update \
    && apt-get install -y git python-pip wget zlib1g-dev libpng12-dev unzip libboost-dev python-numpy python-opencv python-matplotlib python-scipy

RUN git clone https://github.com/mattjr/syntheticcv.git

RUN cd syntheticcv && sh install.sh
