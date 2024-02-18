#!/bin/sh -xe
VERSION=${PYTHON_RUNTIME_VERSION}+${PYTHON_BUILD_VERSION}
if [ "$TARGETARCH" = "amd64" ]; then
    TARGET=x86_64_v3-unknown-linux-gnu
    CONFIG=pgo+lto
elif [ "$TARGETARCH" = "arm64" ]; then
    TARGET=aarch64-unknown-linux-gnu
    CONFIG=lto
fi
FLAVOR=full

DISTRIB=cpython-${VERSION}-${TARGET}-${CONFIG}-${FLAVOR}

wget https://github.com/indygreg/python-build-standalone/releases/download/${PYTHON_BUILD_VERSION}/${DISTRIB}.tar.zst
tar xvf ${DISTRIB}.tar.zst
mv python/install /python
rm -rf ${DISTRIB}.tar.zst python
