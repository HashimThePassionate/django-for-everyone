FROM python:3.12-slim-bullseye
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /code
RUN apt update && apt install -y \
    zlib1g-dev libjpeg-dev libpng-dev libfreetype6-dev liblcms2-dev libtiff5-dev libwebp-dev \
    libharfbuzz-dev libfribidi-dev tk-dev libxcb1-dev \
    && apt clean && rm -rf /var/lib/apt/lists/*
COPY ./requirements.txt .
RUN pip install -r requirements.txt
COPY . .