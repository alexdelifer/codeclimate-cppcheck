#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_UID:-1000}
GROUP_ID=${LOCAL_GROUP_UID:-984}

#echo "Starting with UID:$USER_ID GID:$GROUP_ID"
#useradd --shell /bin/bash -u $USER_ID -o -c "" -m app
addgroup -g $GROUP_ID appgroup
adduser -s /bin/bash -u $USER_ID -G appgroup -H -D -h /code app

# give permissions to app:appuser
chown -R app:appgroup /usr/src/app

#exec /usr/src/app/bin/codeclimate-cppcheck "$@"

VARIABLE="this is a variable"

sudo -i -u app bash << EOF
exec /usr/src/app/bin/codeclimate-cppcheck "$@"
EOF

