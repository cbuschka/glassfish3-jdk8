#!/bin/bash

set -e

if [ "x" = "x${GLASSFISH_ADMIN_PASSWORD}}" ]; then
  echo "ENV variable GLASSFISH_ADMIN_PASSWORD not set."
  exit 1
fi

cat - >/app/.gf.pwd <<EOB
AS_ADMIN_MASTERPASSWORD=${GLASSFISH_ADMIN_PASSWORD}
AS_ADMIN_USERPASSWORD=${GLASSFISH_ADMIN_PASSWORD}
AS_ADMIN_ALIASPASSWORD=${GLASSFISH_ADMIN_PASSWORD}
AS_ADMIN_PASSWORD=
AS_ADMIN_NEWPASSWORD=${GLASSFISH_ADMIN_PASSWORD}
EOB

chmod 600 /app/.gf.pwd
${GLASSFISH_HOME}/bin/asadmin --user admin --passwordfile /app/.gf.pwd --host localhost --port 4848 change-admin-password

cat - >/app/.gf.pwd <<EOB
AS_ADMIN_MASTERPASSWORD=${GLASSFISH_ADMIN_PASSWORD}
AS_ADMIN_USERPASSWORD=${GLASSFISH_ADMIN_PASSWORD}
AS_ADMIN_ALIASPASSWORD=${GLASSFISH_ADMIN_PASSWORD}
AS_ADMIN_PASSWORD=${GLASSFISH_ADMIN_PASSWORD}
EOB

${GLASSFISH_HOME}/bin/asadmin  --user admin --passwordfile /app/.gf.pwd --host localhost --port 4848 enable-secure-admin
