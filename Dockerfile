ARG BASE_TAG=act-latest
FROM catthehacker/ubuntu:${BASE_TAG}

# pyenv
ARG PYTHON_VERSION=3.11
ENV PYENV_ROOT="/pyenv"
RUN curl https://pyenv.run | bash && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION}

# poetry
ENV POETRY_HOME="/poetry"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="$POETRY_HOME/bin:$PATH"

# yq
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq
