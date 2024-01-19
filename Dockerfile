FROM --platform=linux/amd64 ubuntu AS builder

ARG HASH=381b4941466e
ARG VERSION=2023.2.5f1
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  libgtk-3-0 \
  libarchive13 \
  libgl1 \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Remove all apt lists to avoid issues with corrupted cache
RUN rm -rf /var/lib/apt/lists/*

# Remove apt cache
RUN rm -rf /var/cache/apt/*

# Download and install Unity
RUN curl https://download.unity3d.com/download_unity/${HASH}/UnitySetup-${VERSION} --output /unity-installer && chmod +x /unity-installer
RUN echo y | /unity-installer --unattended --components=Unity,Android,iOS --install-location=/opt/unity --download-location=/src/unity

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /project
WORKDIR /project

ENTRYPOINT [ "/entrypoint.sh" ]