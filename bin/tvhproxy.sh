#!/bin/sh

### TVHeadend URL

TVH_URL=$(snapctl get tvh.url)
if [ -z "$TVH_URL" ]; then
	TVH_URL="http://localhost:9981"
fi

export TVH_URL

### Proxy URL

TVH_PROXY_URL=$(snapctl get tvh.proxy-url)
[ -z "$TVH_PROXY_URL" ] && TVH_PROXY_URL="$(echo $TVH_URL | sed -E -e 's|^(https?://)([^/:]+)(:9981)?(/.*)$|http://\2:5004/|')"

export TVH_PROXY_URL

### Tuner Count

TVH_TUNER_COUNT=$(snapctl get tvh.tuner-count)
[ -z "$TVH_TUNER_COUNT" ] && TVH_TUNER_COUNT=1

export TVH_TUNER_COUNT

### Start the server

exec python3 $SNAP/tvhProxy.py "$@"
