# kbengine_env
KBEngine enviroment

## Use port
80 http
20013 WebSocket

## Run
`
docker run --rm -it -p 80:80 -p 20013:20013 -v kbengine_defs.xml:/kbenging/kbe/res/server/kbengine_defs.xml miles990/kbengine_env /bin/sh
`
