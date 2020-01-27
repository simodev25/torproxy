#!/usr/bin/env bash

response=$(curl $1 -H  -H 'pragma: no-cache' -H 'cache-control: no-cache' --compressed)

if [ `echo $response | grep -c $2 ` -gt 0 ]
then
  echo "Success"
else
  echo "Fail";
fi
