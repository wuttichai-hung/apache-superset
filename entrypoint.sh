#!/usr/bin/env bash

superset db upgrade
# superset fab create-admin
superset fab create-admin --username admin  --firstname firstname --lastname lastname --email admin@example.com --password 1234
# Initiliase the metastore
superset init

# Run the scheduler in background
exec superset run -p 8088 -h 0.0.0.0 --with-threads