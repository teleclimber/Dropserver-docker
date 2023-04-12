#!/bin/bash

/usr/local/bin/ds-host -config=/etc/dropserver.json -migrate

exec /usr/local/bin/ds-host -config=/etc/dropserver.json