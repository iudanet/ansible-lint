# Version: 0.0.1
FROM python:3.7-slim
LABEL maintainer="Chudakov Aleksandr chudo@iudanet.com"
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
