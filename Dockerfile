ARG ROS_DISTRO=humble

# Use base image, https://hub.docker.com/_/ros/
FROM ros:$ROS_DISTRO-ros-base

# Prevent console from interacting with the user
ARG DEBIAN_FRONTEND=noninteractive

# Clean previous apt cache and update
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get update -yqqq

# Set folder for RUNTIME_DIR to prevent warnings when running RViz2 and Gazebo
RUN mkdir -p /tmp/runtime-root && chmod 0700 /tmp/runtime-root
ENV XDG_RUNTIME_DIR='/tmp/runtime-root'

RUN apt-get update --fix-missing -y

# Install common dependencies
RUN apt-get install --no-install-recommends -yqqq \
    apt-utils \
    vim \
    git \
    python3-pip \
    ros-$ROS_DISTRO-ros-gz-sim \
    ros-$ROS_DISTRO-ros-gz-interfaces \
    ros-$ROS_DISTRO-ros-gz-bridge \
    ros-$ROS_DISTRO-rviz2 \
    ros-$ROS_DISTRO-xacro \
    ros-$ROS_DISTRO-teleop-twist-keyboard

# Final apt-get clean up to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up shell to use bash commands
SHELL ["/bin/bash", "-c"]

# Environment variables for ROS setup
ENV ROS_DISTRO=$ROS_DISTRO
ENV WORKSPACE=/root/ros2_ws

# Update .bashrc for ROS environment
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc && \
    echo "source $WORKSPACE/install/setup.bash" >> /root/.bashrc

# Set the workspace as the working directory
WORKDIR $WORKSPACE

# Copy workspace contents
COPY workspace/ $WORKSPACE/src/

# Build the workspace
RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
    colcon build

# Source the built workspace
RUN echo "source $WORKSPACE/install/setup.bash" >> /root/.bashrc

