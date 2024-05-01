ARG ROS_DISTRO=iron
FROM osrf/ros:${ROS_DISTRO}-desktop

ARG GODOT_VERSION=4.2.2

# install vulkan utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install --no-install-recommends -y \
    mesa-utils \
    vulkan-tools \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install toolchains
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install --no-install-recommends -y \
    scons \
    g++ \
    unzip \
    wget \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download godot
RUN cd /tmp && \
    wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip && \
    unzip Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip && \
    mv Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot
