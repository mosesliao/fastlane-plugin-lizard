## Build based on CircleCI ruby then install lizard

FROM circleci/ruby

USER root
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y python3-pip
RUN apt-get install -y apt-utils
RUN pip3 install lizard==1.14.5
RUN ruby --version
RUN lizard --version
