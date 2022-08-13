FROM python:3.8-slim
LABEL maintainer="WuttichaiHung"

ENV FLASK_APP=superset
# ENV SUPERSET_CONFIG_PATH=/usr/local/lib/python3.8/site-packages/superset/superset_config.py
# COPY ./superset_config.py ${SUPERSET_CONFIG_PATH}
WORKDIR /usr/local/lib/

RUN pip install --upgrade setuptools pip
RUN apt-get update -yqq && apt-get upgrade -yqq && \
    apt-get install -yqq --no-install-recommends \ 
    apt-utils \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-pip \
    libsasl2-dev \
    libldap2-dev \
    curl vim wget git zip unzip

RUN pip install apache-superset==2.0.0
COPY ./requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install markupsafe==2.0.1
RUN pip install Werkzeug==2.0.3
RUN pip install Flask==2.1.3

COPY ./entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

RUN useradd -ms /bin/bash superset
USER superset
EXPOSE 8088
ENTRYPOINT [ "./entrypoint.sh" ]