#!/bin/sh

docker build \
    -t gcr.io/${PROJECT}/dito-chat-backend \
    backend/.

docker build \
    --build-arg REACT_APP_BACKEND_WS="ws://localhost:8080" \
    --build-arg REACT_APP_BACKEND_URL="http://localhost:8080" \
    -t gcr.io/${PROJECT}/dito-chat-frontend \
    frontend/.

docker push gcr.io/${PROJECT}/dito-chat-backend:latest
docker push gcr.io/${PROJECT}/dito-chat-frontend:latest