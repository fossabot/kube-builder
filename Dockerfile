FROM ubuntu:latest
ARG TARGETARCH
ARG TARGETPLATFORM

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt install -yq --no-install-recommends \
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
RUN chmod +x /usr/local/bin/init-kubectl

COPY build.sh /tmp/
RUN chmod u+x /tmp/build.sh && /tmp/build.sh $TARGETARCH

ENTRYPOINT ["/usr/local/bin/init-kubectl"]