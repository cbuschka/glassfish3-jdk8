FROM openjdk:8-jdk-slim-bullseye

ENV GLASSFISH_INSTALL_DIR=/opt/glassfish3
ENV GLASSFISH_HOME=/opt/glassfish3/glassfish
ENV PATH=${PATH}:${GLASSFISH_INSTALL_DIR}/bin
ENV GLASSFISH_ADMIN_PASSWORD=

RUN useradd -u 1000 app -m -d /app
ADD downloads/glassfish-3.1.2.2.tgz /opt
ADD assets/ /

RUN chown app:app -R /opt/glassfish3 /usr/local/bin/run-gf.sh && \
	echo -e '\njre-1.8=${jre-1.7}\n' >> /opt/glassfish3/glassfish/config/osgi.properties && \
	echo -e '\njdk.tls.disabledAlgorithms=\n' >> $(dirname `which java`)/../jre/lib/security/java.security

WORKDIR /app
USER app

CMD [ "/usr/local/bin/run-gf.sh" ]
