#!/bin/sh

docker build \
    -t gcr.io/${PROJECT}/dito-chat-backend \
    backend/.

# putting the IP address of the load balancer statically here since
# it is needed at image build time, ideally we would have a DNS record
# or change the frontend application to receive the backend address
# at runtime
docker build \
    --build-arg REACT_APP_BACKEND_WS="ws://34.73.123.94:8080" \
    --build-arg REACT_APP_BACKEND_URL="http://34.73.123.94:8080" \
    -t gcr.io/${PROJECT}/dito-chat-frontend \
    frontend/.

docker push gcr.io/${PROJECT}/dito-chat-backend:latest
docker push gcr.io/${PROJECT}/dito-chat-frontend:latest