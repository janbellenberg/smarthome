#!/bin/bash

docker build -t smarthome-api:latest -f src/api/smarthome/Dockerfile .

cd src/app/smarthome
docker build -t smarthome-frontend:latest .