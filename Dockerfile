ARG BASE_TAG=act-latest@sha256:efce7c01d75493a457c82c7394d2707119e30becb706ec1865e64c7c820a3c94
FROM catthehacker/ubuntu:${BASE_TAG}

# python
# renovate: datasource=custom.setup-python depName=python extractVersion=^(?<version>\d+\.\d+)\.\d+$
ARG PYTHON_VERSION=3.12
COPY python.sh .
RUN ./python.sh && rm python.sh
ENV PATH="/python/bin:$PATH"

# poetry
ENV POETRY_HOME="/poetry"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="$POETRY_HOME/bin:$PATH"

# yq
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

# rclone
RUN curl https://rclone.org/install.sh | bash

# hugo
# renovate: datasource=github-tags depName=gohugoio/hugo extractVersion=^v?(?<version>.*)$
ARG HUGO_VERSION=0.122.0
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz && \
    tar -xzf hugo_${HUGO_VERSION}_linux-amd64.tar.gz && \
    mv hugo /usr/bin/hugo && \
    rm hugo_${HUGO_VERSION}_linux-amd64.tar.gz
