#!/bin/bash

set -e

${GLASSFISH_HOME}/bin/asadmin  --user admin --passwordfile /app/.gf.pwd --host localhost --port 4848 set server.admin-service.das-config.autodeploy-polling-interval-in-seconds=1
