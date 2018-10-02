## Build based on CircleCI ruby then install lizard

FROM circleci/ruby

USER root
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y python3-pip
RUN pip3 install lizard --upgrade

ADD .gem/ /root/.gem
RUN ls -lah ~
RUN cat ~/.gem/credentials
RUN chmod 600 ~/.gem/credentials
