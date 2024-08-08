# Pull base image
FROM python:3.12-slim

# set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# set work directory
WORKDIR /code

# install dependencies
COPY ./requirements.txt / .

RUN pip install -r requirements.txt

# copy project
COPY . / .