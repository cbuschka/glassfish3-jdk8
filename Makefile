PROJECT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

run:
	@cd ${PROJECT_DIR}
	docker run --init -m 8g --name gf3-server --rm -ti \
		-p 4848:4848 -p 8080:8080 -p 8181:8181 \
		-e GLASSFISH_ADMIN_PASSWORD=asdfasdf \
		glassfish3-jdk8:local

build-ear:
	@cd ${PROJECT_DIR}
	cd example && \
	mvn package --batch-mode && \
	cd .. && \
	cp example/ear/target/example.ear ${PROJECT_DIR}/generated/

build:	build-ear patch-glassfish
	@cd ${PROJECT_DIR}
	docker build --tag glassfish3-jdk8:local .

download:
	@cd ${PROJECT_DIR}
	cd ${PROJECT_DIR}/downloads && \
	mkdir -p ${PROJECT_DIR}/downloads/ && \
	if [ ! -f "./glassfish-3.1.2.2.zip" ]; then \
	  wget http://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip; \
	fi

patch-glassfish:	download
	rm -rf /tmp/prepare-gf3 && \
	mkdir -p /tmp/prepare-gf3 && \
	cd /tmp/prepare-gf3 && \
	unzip -x ${PROJECT_DIR}/downloads/glassfish-3.1.2.2.zip && \
	echo -e '\njre-1.8=$${jre-1.7}\n' >> glassfish3/glassfish/config/osgi.properties && \
	mkdir -p glassfish3/glassfish/domains/domain1/autodeploy/ && \
	mkdir -p ${PROJECT_DIR}/generated && \
	tar cv glassfish3 | gzip -c > ${PROJECT_DIR}/generated/glassfish-3.1.2.2-patched.tgz && \
	rm -rf /tmp/prepare-gf3
