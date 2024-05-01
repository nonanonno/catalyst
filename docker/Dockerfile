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
    clang \
    unzip \
    wget \
    curl \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download godot
RUN cd /tmp && \
    wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip && \
    unzip Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip && \
    mv Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot

# Install Rust
ENV RUST_HOME /usr/local/lib/rust
ENV RUSTUP_HOME ${RUST_HOME}/rustup
ENV CARGO_HOME ${RUST_HOME}/cargo
RUN mkdir ${RUST_HOME} && chmod 0755 ${RUST_HOME} && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > ${RUST_HOME}/rustup.sh && \
    chmod +x ${RUST_HOME}/rustup.sh && \
    ${RUST_HOME}/rustup.sh -y --no-modify-path
ENV PATH $PATH:${CARGO_HOME}/bin
