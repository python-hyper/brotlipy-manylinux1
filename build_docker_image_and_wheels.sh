#!/bin/bash
set -xe

#x86_64
docker build --rm -t brotlipy-manylinux1-x86_64-builder -f docker/Dockerfile-x86_64 .
docker run -v `pwd`/build:/build --rm brotlipy-manylinux1-x86_64-builder /root/scripts/create_brotlipy_wheels.sh
#x86
docker build --rm -t brotlipy-manylinux1-x86-builder -f docker/Dockerfile-i686 .
docker run -v `pwd`/build:/build --rm brotlipy-manylinux1-x86-builder linux32 /root/scripts/create_brotlipy_wheels.sh
