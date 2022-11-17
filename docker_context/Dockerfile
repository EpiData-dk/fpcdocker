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
    && rm -rf /var/lib/apt/lists/*
RUN pip install yq grip

COPY output/ /

RUN ldconfig

ENV PATH=$PATH:/opt/osxcross/bin:/fpc/bin/