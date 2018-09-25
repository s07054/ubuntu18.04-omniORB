#Download base image ubuntu 16.04
FROM ubuntu:18.04
# Update Ubuntu Software repository
RUN apt-get update
RUN yes Y | apt-get upgrade
RUN yes Y | apt-get install wget
RUN yes Y | apt-get install build-essential checkinstall
RUN yes Y | apt-get install python-dev
RUN wget https://sourceforge.net/projects/omniorb/files/omniORB/omniORB-4.2.2/omniORB-4.2.2.tar.bz2
ADD ci.sh ci.sh
RUN tar -xjvf omniORB-4.2.2.tar.bz2
RUN cd omniORB-4.2.2 && ./configure && make && ../ci.sh

