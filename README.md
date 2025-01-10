Here's the updated README with the `cd docker_scripts/` step included:

---

# Sample ROS2 Humble Docker

This repository provides a pre-configured Docker setup for working with ROS2 Humble. It includes scripts for ease of use with and without the current working directory (PWD) mounted under `workspace/src`.

## Getting Started

Follow the steps below to set up and run the Docker container:

### Prerequisites
- Install Docker on your system. Refer to the [Docker installation guide](https://docs.docker.com/get-docker/) for detailed instructions.

### Build the Docker Image
```bash
docker build -t sample_ros2_docker .
```

### Run the Container
Navigate to the `docker_scripts` directory and use one of the following commands:
```bash
cd docker_scripts/
```

- **With PWD mounted under `workspace/src`:**
  ```bash
  ./devel.sh
  ```
- **Without PWD mounted:**
  ```bash
  ./base.sh
  ```

### Access the Container's Bash Terminal
To open a Bash terminal inside the container, run:
```bash
./enter_bash.sh
```

## File Structure
- **Dockerfile**: Defines the Docker image configuration.
- **Scripts**:
  - `devel.sh`: Starts the container with the current working directory mounted under `workspace/src`.
  - `base.sh`: Starts the container without mounting the current working directory.
  - `enter_bash.sh`: Opens a Bash terminal for the running container.

---

This setup allows you to easily develop and test ROS2 Humble projects in a Dockerized environment.
