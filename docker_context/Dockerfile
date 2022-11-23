FROM ubuntu:20.04

RUN apt update && \
  DEBIAN_FRONTEND="noninteractive" apt install -y \
    subversion \
    git \
    libgtk2.0-dev \
    clang \
    maven \
    wget \
    curl \
    pip \
    jq \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install yq grip jinja2-cli

COPY output/ /

RUN ldconfig

ENV PATH=$PATH:/opt/osxcross/bin:/fpc/bin/