FROM python:3.8-alpine
MAINTAINER Dogukan Cagatay <dcagatay@gmail.com>

ENV CURA_VERSION "4.5.0"
ENV UID "5000"
ENV GID "5000"

RUN apk add --no-cache \
	bash \
	git \
	openssh \
	ffmpeg \
	wget \
	protobuf \
	protobuf-dev \
	cmake \
	build-base \
	python3-dev \
	linux-headers \
	py3-sip-dev

RUN cd /tmp && \
  wget https://github.com/Ultimaker/libArcus/archive/${CURA_VERSION}.tar.gz && \
  tar -zxf ${CURA_VERSION}.tar.gz && \
  cd libArcus-${CURA_VERSION} && \
  mkdir build && \
  cd build && \
  cmake ../ && \
  make && \
  make install && \
  cd /tmp && \
  wget https://github.com/Ultimaker/CuraEngine/archive/${CURA_VERSION}.tar.gz && \
  tar -zxf ${CURA_VERSION}.tar.gz.1 && \
  cd CuraEngine-${CURA_VERSION} && \
  mkdir build && \
  cd build && \
  cmake ../ && \
  make && \
  make install && \
  rm -Rf /tmp/${CURA_VERSION}.tar.gz /tmp/CuraEngine-${CURA_VERSION} /tmp/${CURA_VERSION}.tar.gz.1 /tmp/libArcus-${CURA_VERSION}

RUN	pip install OctoPrint==1.4.0 && \
  addgroup -g ${GID} octoprint && \
  adduser -u ${UID} -h /home/octoprint -s /bin/bash -D -G octoprint octoprint && \
  adduser octoprint dialout && \
  mkdir -p /data && \
  chown -R ${UID}:${GID} /data

VOLUME /data
EXPOSE 5000
WORKDIR /data

USER octoprint
CMD ["octoprint", "serve", "--config", "/data/config.yaml", "--basedir", "/data"]
