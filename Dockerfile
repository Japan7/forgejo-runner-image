ARG BASE_TAG=act-latest
FROM catthehacker/ubuntu:${BASE_TAG}

# python
# renovate: datasource=docker depName=python
ARG PYTHON_VERSION=3.11
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
# renovate: datasource=github-tags depName=gohugoio/hugo versioning=semver-coerced
ARG HUGO_VERSION=0.120.3
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz && \
    tar -xzf hugo_${HUGO_VERSION}_linux-amd64.tar.gz && \
    mv hugo /usr/bin/hugo && \
    rm hugo_${HUGO_VERSION}_linux-amd64.tar.gz
