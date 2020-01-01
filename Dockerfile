FROM ubuntu:19.04
MAINTAINER Jaewon Chung <jaywonchung@snu.ac.kr>

# install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      m4 \
      vim \
      cmake \
      cython \
      libgomp1 \
      libblas-dev \
      libjpeg-turbo8 \
      libjpeg-turbo8-dev \
      libopenblas-dev \
      python3-pip \
      python3-dev \
      python3-yaml \
      python3-numpy \
      python3-wheel \
      python3-pillow \
      python3-distutils \
      python3-setuptools && \
    rm -rf /var/lib/apt/lists/*

# install pytorch and torchvision
#  pip packages
WORKDIR /wheels
COPY ./wheels .
RUN pip3 install --no-cache-dir torch-1.2.0a0+8554416-cp37-cp37m-linux_armv7l.whl && \
    pip3 install --no-cache-dir torchvision-0.4.0a0+d31eafa-cp37-cp37m-linux_armv7l.whl && 
    cd .. && rm -r wheels
#  fix torch._C ImportError
WORKDIR /usr/local/lib/python3.7/dist-packages/torch
RUN mv _C*.so _C.so && \
    mv _dl*.so _dl.so

# finish
WORKDIR /prj
