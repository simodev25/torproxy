#!/usr/bin/env bash

UA=$(cat /usr/bin/ua.txt | sort -R  | head -1)

response=$(curl --socks5 localhost:9050 --socks5-hostname localhost:9050 -A "$UA"  $1  --compressed -s)

if [ `echo $response | grep -c $2 ` -gt 0 ]
then
  echo 'ok'
  exit 0
else
  echo 'ko'
  exit 1
fi
