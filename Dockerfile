ARG BASE_TAG=act-latest@sha256:efce7c01d75493a457c82c7394d2707119e30becb706ec1865e64c7c820a3c94
FROM catthehacker/ubuntu:${BASE_TAG}

ARG TARGETARCH

# python
# renovate: datasource=custom.setup-python depName=python
ARG PYTHON_VERSION=3.12.2
COPY python.sh .
RUN ./python.sh && rm python.sh
ENV PATH="/python/bin:$PATH"

# poetry
# renovate: datasource=github-releases depName=python-poetry/poetry
ARG POETRY_VERSION=1.7.1
ENV POETRY_HOME="/poetry"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="$POETRY_HOME/bin:$PATH"

# yq
# renovate: datasource=github-releases depName=mikefarah/yq
ARG YQ_VERSION=v4.41.1
RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${TARGETARCH} -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

# rclone
# renovate: datasource=github-releases depName=rclone/rclone
ARG RCLONE_VERSION=v1.65.2
ENV RCLONE_ARCHIVE=rclone-${RCLONE_VERSION}-linux-${TARGETARCH}
RUN wget https://github.com/rclone/rclone/releases/download/${RCLONE_VERSION}/${RCLONE_ARCHIVE}.zip && \
    unzip ${RCLONE_ARCHIVE}.zip && \
    mv rclone-${RCLONE_VERSION}-linux-${TARGETARCH}/rclone /usr/bin/rclone && \
    rm -rf ${RCLONE_ARCHIVE}*

# hugo
# renovate: datasource=github-releases depName=gohugoio/hugo extractVersion=^v?(?<version>.*)$
ARG HUGO_VERSION=0.122.0
ENV HUGO_ARCHIVE=hugo_${HUGO_VERSION}_linux-${TARGETARCH}
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ARCHIVE}.tar.gz && \
    mkdir hugo_release && \
    tar xzf ${HUGO_ARCHIVE}.tar.gz -C hugo_release && \
    mv hugo_release/hugo /usr/bin/hugo && \
    rm -rf ${HUGO_ARCHIVE}* hugo_release
