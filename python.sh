#!/bin/sh -xe

MANIFEST_URL=https://raw.githubusercontent.com/actions/python-versions/main/versions-manifest.json

LATEST_MINOR=$(
    curl $MANIFEST_URL |
    jq -r .[].version |
    grep $PYTHON_VERSION |
    head -n 1   # assuming that the latest minor version is the first one
)

ARCHIVE_URL=$(
    curl $MANIFEST_URL |
    jq -r ".[]
        | select(.version == \"${LATEST_MINOR}\")
        | .files[]
        | select(.arch == \"x64\" and .platform_version == \"${LSB_RELEASE}\")
        | .download_url"
)

wget $ARCHIVE_URL -O python.tar.gz
mkdir -p python
tar xvzf python.tar.gz -C python
(cd python/ && bash setup.sh)

rm -rf python.tar.gz python
