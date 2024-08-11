# Pull base image
FROM python:3.12-slim

# Install necessary system dependencies
RUN apt update \
    && apt install -y libpq-dev gcc \
    && apt clean

# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Copy project
COPY . .