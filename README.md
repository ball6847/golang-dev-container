# Go Base Image

This repository contains a base Docker image for Go services.

## Description

This Docker image is based on the latest Debian-based Go official image and includes:
- librdkafka development libraries from Confluent Platform
- gow (Go file watcher) for development
- Pre-configured Kafka client dependencies

**Release Policy:** This image is automatically updated and released whenever a new Go version is available, always maintaining compatibility with Debian-based distributions.

## Usage

This image is automatically built and pushed to DockerHub with branch-based tagging. Services can use it as a base image:

```dockerfile
# Use the latest Go version
FROM ball6847/go-dev-container:latest (latest golang on latest bookworm)

# Or use a specific Go version
FROM ball6847/go-dev-container:1.24-bookworm (1.24 on bookworm)
FROM ball6847/go-dev-container:1.25-bookworm (1.25 on bookworm)

# Your service-specific instructions here
COPY . /app
WORKDIR /app
RUN go build -o main .
CMD ["./main"]
```

## Available Tags

### Version-Specific Tags
- `latest` - Latest Go version (built from `latest` branch)
- `1.24-bookworm` - Go 1.24 with Debian Bookworm (built from `1.24-bookworm` branch)
- `1.25-bookworm` - Go 1.25 with Debian Bookworm (built from `1.25-bookworm` branch)

## Branch Strategy

This repository uses dedicated branches for different Go versions:
- `latest` - Latest Go version always on `main` branch
- `1.24-bookworm` - Go 1.24 with Debian Bookworm
- `1.25-bookworm` - Go 1.25 with Debian Bookworm

Each branch contains the appropriate Dockerfile for that specific Go version.

## Building Locally

```bash
docker build -t go-dev-container .
```

## Manual Tagging and Pushing

```bash
# Tag for different Go versions
docker tag go-dev-container ball6847/go-dev-container:latest
docker tag go-dev-container ball6847/go-dev-container:1.24-bookworm
docker tag go-dev-container ball6847/go-dev-container:1.25-bookworm
docker tag go-dev-container ball6847/go-dev-container:bookworm

# Push to DockerHub
docker push ball6847/go-dev-container:latest
docker push ball6847/go-dev-container:1.24-bookworm
docker push ball6847/go-dev-container:1.25-bookworm
docker push ball6847/go-dev-container:bookworm
```

## Included Packages

- Latest Debian-based Go official image (automatically updated)
- librdkafka-dev (Kafka client library)
- gow (Go file watcher for development)
- Confluent Platform repository setup

## Exposed Ports

- 8080 (default application port)
