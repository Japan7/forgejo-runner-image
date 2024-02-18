#!/bin/sh -xe
MANIFEST_URL=https://raw.githubusercontent.com/actions/python-versions/main/versions-manifest.json

ARCH=$TARGETARCH
if [ "$ARCH" = "amd64" ]; then
    ARCH=x64
fi

ARCHIVE_URL=$(
    curl $MANIFEST_URL |
    jq -r ".[]
        | select(.version == \"${PYTHON_VERSION}\")
        | .files[]
        | select(.arch == \"${ARCH}\" and .platform_version == \"${LSB_RELEASE}\")
        | .download_url"
)

wget $ARCHIVE_URL -O python.tar.gz
mkdir -p /python
tar xvzf python.tar.gz -C /python
(cd /python && bash setup.sh)

rm -rf python.tar.gz /python/*.tgz
