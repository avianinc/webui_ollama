#!/bin/bash

# Start Docker Compose services
docker-compose up -d

# Build and run pipelines
docker build -t pipelines pipelines/.
docker run -d -p 9099:9099 --add-host=host.docker.internal:host-gateway -e PIPELINES_URLS="https://github.com/open-webui/pipelines/blob/main/examples/filters/detoxify_filter_pipeline.py" -v pipelines:/app/pipelines --name pipelines --restart always pipelines 
# docker run -d -p 9099:9099 --add-host=host.docker.internal:host-gateway -v pipelines:/app/pipelines --name pipelines --restart always ghcr.io/open-webui/pipelines:main

# Run the cloudflair host
docker run -d --network host cloudflare/cloudflared:latest tunnel --no-autoupdate run --token $CLOUDFLARE_TOKEN_INT64_VPC1