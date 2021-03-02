# Setup <!-- omit in toc -->

- [Docker and NVIDIA Container Toolkit](#docker-and-nvidia-container-toolkit)
- [Isaac SDK](#isaac-sdk)
  - [Natively](#natively)
  - [Docker](#docker)
- [Nucleus Core](#nucleus-core)
  - [Natively](#natively-1)
  - [Docker](#docker-1)
- [Omniverse Isaac Sim](#omniverse-isaac-sim)
  - [Natively](#natively-2)
  - [Docker](#docker-2)
    - [Run in windowed mode](#run-in-windowed-mode)
    - [Run in headless mode](#run-in-headless-mode)
- [Common Docker Network](#common-docker-network)

## Docker and NVIDIA Container Toolkit

Follow the [installation guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) of NVIDIA Container Toolkit to install both Docker-CE and NVIDIA Container Toolkit.

## Isaac SDK

Isaac SDK can run either natively or in a docker. Running natively is recommended for plug-and-play equipment.

### Natively

To run Isaac SDK in local environment natively, follow the [guide](https://docs.nvidia.com/isaac/isaac/doc/setup.html) in Isaac SDK documentation.

### Docker

- Create Image

```bash
cd isaac
./engine/engine/build/docker/create_image.sh
```

- Create cache volume for faster builds

```bash
docker volume create isaac-sdk-build-cache
```

- Create and start the container. Note to attach the [notebook config file](../template/jupyter_notebook_config.py) to allow root user and remote access when running the first time.

```bash
docker run -it --rm \
    --mount source=isaac-sdk-build-cache,target=/root \
    -v $(pwd):/src/workspace \
    -v PATH_TO_CONFIG:/src/jupyter_notebook_config.py \
    -w /src/workspace/sdk \
    --gpus all \
    --name isaac_sdk \
    isaacbuild:latest /bin/bash

cp /src/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
```

- Build all Isaac SDK examples inside container (optional)

```bash
bazel build ...
```

## Nucleus Core

Nucleus stores digital assets and virtual worlds for various Omniverse client applications. Clients can publish modification or subscribe to the changes of the assets in real time. To learn more, visit [Nucleus documentation](https://docs.omniverse.nvidia.com/prod_nucleus/prod_nucleus/overview/description.html).

### Natively

To install Nucleus Server in Linux, follow the [guide](https://docs.omniverse.nvidia.com/app_isaacsim/app_isaacsim/setup.html#isaac-sim-setup-nucleus-installation-linux) in Omniverse documentation.

### Docker

Note that additional access is needed for NGC Omniverse Containers. Contact your NVIDIA's point person to have the access enabled.

- Login into NGC

```bash
docker login nvcr.io
```

- Install [docker-compose](https://docs.docker.com/compose/install/).

- Download and extract the Nucleus Core compose files from [Nucleus](https://docs.omniverse.nvidia.com/prod_nucleus/prod_nucleus/installation/docker.html#nucleus-core).

- Read `nucleus-stack.env` **CAREFULLY** to set correct environment variables.

  - Set correct host IP `EXTERNAL_IP_OR_HOST`.
  - Set a name for the instance `INSTANCE_NAME`.
  - Set password for superuser.
  - Set the desired data storage location `DATA_ROOT`.
  - Check port and container subnet has no conflicts with the host system, such as `WEB_PORT`.

- Generate secret set (**INSECURE**)

```bash
./generate-sample-insecure-secrets.sh
```

- Start the server with docker-compose

```bash
docker-compose --env-file nucleus-stack.env -f nucleus-stack.yml up -d
```

- Errors on Startup:

  - Give it some time to let docker restart containers to meet all dependencies
  - Check firewall status

- Follow [guide](https://docs.omniverse.nvidia.com/app_isaacsim/app_isaacsim/setup.html#adding-samples-assets) to add sample assets to Nucleus Server.

## Omniverse Isaac Sim

Omniverse Isaac Sim can run either natively or in a docker. It requires RTX-enabled GPUs for the best rendering.

### Natively

To run Omniverse Isaac Sim in local environment natively, follow the [guide](https://docs.omniverse.nvidia.com/app_isaacsim/app_isaacsim/setup.html#running-natively) in Omniverse Isaac Sim documentation. Running natively is recommended at current stage.

### Docker

Note that the docker version is in **Early Access**.

- Login into NGC

```bash
docker login nvcr.io
```

#### Run in windowed mode

```bash
xhost +local:

docker run --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /etc/localtime:/etc/localtime:ro \
    -e DISPLAY=unix${DISPLAY} \
    -e "ACCEPT_EULA=Y" \
    -e "OMNI_USER=<username>" \
    -e "OMNI_PASS=<userpass>" \
    -e "OMNI_SERVER=<ip_address>" \
    --gpus all \
    --network=host \
    --entrypoint ./runapp.sh \
    --name isaac_sim \
    nvcr.io/nvidia/isaac-sim:2020.2.2_ea
```

#### Run in headless mode

- Create and start the container

```bash
docker run --rm \
    -e "ACCEPT_EULA=Y" \
    -e "OMNI_USER=<username>" \
    -e "OMNI_PASS=<userpass>" \
    -e "OMNI_SERVER=<ip_address>" \
    -p 47995-48012:47995-48012/udp \
    -p 47995-48012:47995-48012/tcp \
    -p 49000-49007:49000-49007/tcp \
    -p 49000-49007:49000-49007/udp \
    --gpus all \
    --name isaac_sim \
    nvcr.io/nvidia/isaac-sim:2020.2.2_ea
```

- Download Omniverse Kit Remote Clients on client machine from [Isaac Sim 2020.2 (Omniverse Early Access)](https://developer.nvidia.com/isaac-sim/download) and install required packages:

```bash
sudo apt-get install libavcodec57 libavformat57 libavutil55 libsdl2-dev libsdl2-2.0-0
```

- Access Omniverse Kit instance

```bash
./omniverse-kit-remote.sh -s <remote_ip_address>

# to get all options
./omniverse-kit-remote.sh --help
```

## Common Docker Network

If containers like `isaac_sdk` and `isaac_sim` is running on the same machine, a common network can be created for easy inter-container communication.

- Create network

```bash
docker network create -d bridge isaac
```

- Attach at creation: set `--network=isaac`
- Attach existing container

```bash
docker network connect isaac CONTAINER_NAME
```
