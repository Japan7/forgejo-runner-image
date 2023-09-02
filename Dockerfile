ARG BASE_TAG=act-latest
FROM catthehacker/ubuntu:${BASE_TAG}

# python
ARG PYTHON_VERSION=3.11
COPY python.sh .
RUN ./python.sh && rm python.sh

# poetry
ENV POETRY_HOME="/poetry"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="$POETRY_HOME/bin:$PATH"

# yq
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq
