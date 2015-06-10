#!/bin/bash
echo "Stop all msdemo container if exists..."
docker ps --all | grep "msdemo-*" | cut -c -12 | xargs docker stop
docker ps --all | grep "msdemo-*" | cut -c -12 | xargs docker rm

