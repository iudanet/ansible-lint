# Version: 0.0.3
FROM python:3.10.1-alpine3.14 AS base
RUN apk add --no-cache --update \
    openssh-client \
    bash \
    git \
    make \
    sshpass
FROM base AS builder

RUN apk add --no-cache --update \
    linux-headers \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev


ENV VIRTUAL_ENV=/opt/venv
ENV PIP_VERSION=21.3.1
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN python3 -m venv  $VIRTUAL_ENV

COPY requirements.txt /requirements.txt
RUN  pip install --no-cache-dir --upgrade pip==${PIP_VERSION} \
        && pip install --no-cache-dir -r /requirements.txt

FROM base
LABEL maintainer="Chudakov Aleksandr chudo@iudanet.com"
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
COPY --from=builder $VIRTUAL_ENV $VIRTUAL_ENV
