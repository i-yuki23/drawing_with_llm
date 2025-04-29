FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04

ENV PYTHON_MAJOR_VERSION=3
ENV PYTHON_MINOR_VERSION=12
ENV PYTHON_PATCH_VERSION=0
ENV PYTHON_VERSION=${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION}.${PYTHON_PATCH_VERSION}
ENV POETRY_VERSION=2.1.2
ENV POETRY_HOME=/opt/poetry

ARG USERNAME
ARG USER_UID

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# インストールするパッケージを最新にする→全部yesと答える＋推奨パッケージは入れない
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    netbase \
    tzdata \
    dpkg-dev \
    gcc \
    gnupg dirmngr \
    libbluetooth-dev \
    libbz2-dev \
    libc6-dev \
    libdb-dev \
    libexpat1-dev \
    libffi-dev \
    libgdbm-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    make \
    curl \
    tk-dev \
    uuid-dev \
    wget \
    xz-utils \
    zlib1g-dev \
    git \
    openssh-client \
    zsh \
    zip \
    unzip \
    bash-completion \
    software-properties-common \
    libopenblas-dev \
    libjpeg-dev \
    libpng-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# pythonのインストール
RUN curl -o python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
    && tar xJf python.tar.xz \
    && rm python.tar.xz

WORKDIR /Python-${PYTHON_VERSION}

RUN ./configure \
    && make \
    && make install \
    && cd / \
    && rm -rf /Python-${PYTHON_VERSION}


# インストールしたpythonバージョンに合わせたpipをインストールし、pythonのリンクを貼り直す
RUN add-apt-repository universe \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    python3-pip \
    python3-dev\
    && rm -rf /usr/bin/python \
    && ln -s /usr/local/bin/python${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION} /usr/bin/python \
    && python -m pip install --no-cache-dir pip --force-reinstall \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# poetryのインストール
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -sSL https://install.python-poetry.org/ | python3 - --version ${POETRY_VERSION} && \
    ln -s ${POETRY_HOME}/bin/poetry /usr/local/bin/poetry


# ホストとコンテナのユーザーを合わせる
RUN useradd --uid ${USER_UID} -m ${USERNAME} 

USER $USERNAME

WORKDIR /home/$USERNAME/
