FROM ubuntu:latest
ARG TARGETPLATFORM

RUN sed -i -e 's/archive\.ubuntu\.com\/ubuntu\//apt-mirror\.support\.tools\/ubuntu\//' /etc/apt/sources.list

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    wget \
    openssh-client \
    git \
    zip \
    unzip \
    awscli \
    rsync \
    jq \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY init-kubectl /usr/local/bin/

## Install kubectl
RUN curl -sLf https://storage.googleapis.com/kubernetes-release/release/$(curl -ks https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/${TARGETPLATFORM}/kubectl > /usr/local/bin/kubectl && \
chmod +x /usr/local/bin/kubectl && \
kubectl

## Install Helm3
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
chmod +x get_helm.sh && \
./get_helm.sh && \
helm