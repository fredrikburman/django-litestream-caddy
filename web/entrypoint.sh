#!/bin/sh

# if the db file doesn't exist we get it from the REPLICA_URL
[ ! -f $DB_FILE ] && litestream restore -v -if-replica-exists -o $DB_FILE "${REPLICA_URL}" \
  ; python manage.py migrate \
  ; python manage.py collectstatic --no-input --clear \
  ; litestream replicate -exec "python manage.py runserver 0.0.0.0:8000" $DB_FILE "${REPLICA_URL}"

