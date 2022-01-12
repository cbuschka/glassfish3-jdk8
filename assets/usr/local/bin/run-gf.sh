#!/bin/bash

set -e

PATH=${GLASSFISH_INSTALL_DIR}/bin:${PATH}

cd ${GLASSFISH_INSTALL_DIR}

asadmin start-domain 
for f in $(find /docker-entrypoint.d/ -name '*.sh' | sort); do
  STATE_FILE=/app/.$(basename $f .sh).DONE
  if [ ! -f ${STATE_FILE} ]; then
    echo "Running $f..."
    $f
    touch ${STATE_FILE}
  fi
done

echo "Restarting gf..."
asadmin stop-domain
asadmin start-domain --verbose
