FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
libpq-dev \
gcc \

build-essential \
libssl-dev \
libffi-dev \
python3-dev \
postgresql-client \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

ENTRYPOINT ["/bin/sh", "-c", "python3 bot.py"]
