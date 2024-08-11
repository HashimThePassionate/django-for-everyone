FROM python:3.12-slim
RUN apt update \
    && apt install -y libpq-dev gcc \
    && apt clean
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /code
COPY ./requirements.txt .
RUN pip install -r requirements.txt
COPY . .