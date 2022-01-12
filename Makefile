PROJECT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

run:	build
	@cd ${PROJECT_DIR}
	docker run --init -m 8g --name gf3-server --rm -ti \
		-p 4848:4848 -p 8080:8080 -p 8181:8181 \
		-e GLASSFISH_ADMIN_PASSWORD=asdfasdf \
		glassfish3-jdk8:local

build:	download
	@cd ${PROJECT_DIR}
	docker build --tag glassfish3-jdk8:local .

download:
	@cd ${PROJECT_DIR}
	if [ ! -f "${PROJECT_DIR}/downloads/glassfish-3.1.2.2.tgz" ]; then \
	  mkdir -p ${PROJECT_DIR}/downloads/ && \
	  cd downloads/ && \
	  mkdir /tmp/prepare-gf3 && \
	  cd /tmp/prepare-gf3 && \
	  wget http://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip && \
	  unzip -x glassfish-3.1.2.2.zip && \
	  rm glassfish-3.1.2.2.zip && \
	  cd /tmp/prepare-gf3/ && \
	  tar cv * | gzip -c > ${PROJECT_DIR}/downloads/glassfish-3.1.2.2.tgz; \
	fi
