#!/bin/sh -xe
API_URL=https://api.github.com/repos/indygreg/python-build-standalone/releases/tags/${PYTHON_BUILD_VERSION}

if [ "$TARGETARCH" = "amd64" ]; then
    TARGET=x86_64_v3-unknown-linux-gnu
    CONFIG=pgo+lto
elif [ "$TARGETARCH" = "arm64" ]; then
    TARGET=aarch64-unknown-linux-gnu
    CONFIG=lto
fi
FLAVOR=full

# Assuming there is only one patch release for a given minor version
DISTRIB=$(
    curl -s $API_URL |
    jq -r '.assets[].name' |
    grep -v 'sha256' |
    grep "${PYTHON_RUNTIME_MINOR}.*+${PYTHON_BUILD_VERSION}-${TARGET}-${CONFIG}-${FLAVOR}"
)

wget https://github.com/indygreg/python-build-standalone/releases/download/${PYTHON_BUILD_VERSION}/${DISTRIB}
tar xvf ${DISTRIB}
mv python/install /python
rm -rf ${DISTRIB} python
