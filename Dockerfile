FROM oraclejdk:8-jre-centos

# author
MAINTAINER Sinton<https://github.com/Sinton>

WORKDIR /usr/local/coco

ADD ./Coco.jar ./Coco.jar

ADD ./docker-entrypoint.sh ./docker-entrypoint.sh

ENV COCO_VERSION=1.0.0 \
    COCO_STORAGE_DIR=/data

RUN set -ex && \
    chmod a+x ./docker-entrypoint.sh && \
    # install necessary tools
    yum install -y unzip && \
    yum clean all && \
    # download docker-compose
    DOCKER_COMPOSE_PROJECT_DOWNLOAD_URL="https://github.com/docker/compose/releases/download" && \
    DOCKER_COMPOSE_VERSION=1.27.4 && \
    curl -L "${DOCKER_COMPOSE_PROJECT_DOWNLOAD_URL}/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod a+x /usr/local/bin/docker-compose && \
    # download arthas
    ARTHAS_PROJECT_DOWNLOAD_URL="https://github.com/alibaba/arthas/releases/download" && \
    ARTHAS_VERSION=3.4.6 && \
    curl -L "${ARTHAS_PROJECT_DOWNLOAD_URL}/arthas-all-${ARTHAS_VERSION}/arthas-bin.zip" -o /usr/local/arthas-bin.zip && \
    unzip /usr/local/arthas-bin.zip -d /usr/local/arthas && \
    rm -rf /usr/local/arthas-bin.zip

# api and socket server port
EXPOSE 8080 \
       9099

ENTRYPOINT ["./docker-entrypoint.sh"]
