FROM golang:1.24-bookworm

# Install librdkafka from Confluent Platform repository
RUN apt-get update && apt-get install -y \
    wget \
    gpg \
    lsb-release \
    && mkdir -p /etc/apt/keyrings \
    && wget -qO - https://packages.confluent.io/deb/8.0/archive.key | gpg --dearmor | tee /etc/apt/keyrings/confluent.gpg > /dev/null \
    && CP_DIST=$(lsb_release -cs) \
    && echo "Types: deb\nURIs: https://packages.confluent.io/deb/8.0\nSuites: stable\nComponents: main\nArchitectures: $(dpkg --print-architecture)\nSigned-by: /etc/apt/keyrings/confluent.gpg\n\nTypes: deb\nURIs: https://packages.confluent.io/clients/deb/\nSuites: ${CP_DIST}\nComponents: main\nArchitectures: $(dpkg --print-architecture)\nSigned-By: /etc/apt/keyrings/confluent.gpg" | tee /etc/apt/sources.list.d/confluent-platform.sources > /dev/null \
    && apt-get update \
    && apt-get install -y librdkafka-dev \
    && rm -rf /var/lib/apt/lists/* \
    && go install github.com/mitranim/gow@latest

EXPOSE 8080
