# Version: 0.0.3
FROM python:3.9.2-alpine AS base
RUN apk add --no-cache --update openssh-client bash git make sshpass
FROM base AS builder
LABEL maintainer="Chudakov Aleksandr chudo@iudanet.com"

RUN apk add --no-cache --update linux-headers gcc musl-dev python3-dev libffi-dev openssl-dev

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv  $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

FROM base
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
# RUN apk add --no-cache --update libxslt-dev
COPY --from=builder $VIRTUAL_ENV $VIRTUAL_ENV
