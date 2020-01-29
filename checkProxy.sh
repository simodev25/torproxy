#!/usr/bin/env bash

UA=$(cat ua.txt | sort -R  | head -1)

response=$(curl --socks5 localhost:9050 --socks5-hostname localhost:9050 -A "$UA"  $1  --compressed)

if [ `echo $response | grep -c $2 ` -gt 0 ]
then
  echo "Success"
else
  echo "Fail";
fi
