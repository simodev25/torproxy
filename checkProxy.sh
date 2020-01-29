#!/usr/bin/env bash

UA=$(cat /usr/bin/ua.txt | sort -R  | head -1)
echo $UA
response=$(curl --socks5 localhost:9050 --socks5-hostname localhost:9050 -A "$UA"  $1  --compressed)

if [ `echo $response | grep -c $2 ` -gt 0 ]
then
  echo 'ok'
  exit 1
else
  echo 'ko'
  exit 0
fi
