FROM ubuntu:20.04

RUN apt update && \
  DEBIAN_FRONTEND="noninteractive" apt install -y \
    subversion \
    git \
    libgtk2.0-dev \
    clang \
    maven \
    && rm -rf /var/lib/apt/lists/*
COPY output/ /

RUN ldconfig

ENV PATH=$PATH:/opt/osxcross/bin:/fpc/bin/