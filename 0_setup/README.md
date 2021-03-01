# Setup <!-- omit in toc -->

- [Docker and NVIDIA Container Toolkit](#docker-and-nvidia-container-toolkit)
- [Isaac SDK](#isaac-sdk)
  - [Natively](#natively)
  - [Docker](#docker)
- [Nucleus Server](#nucleus-server)
  - [Natively](#natively-1)
  - [Docker](#docker-1)
- [Omniverse Isaac Sim](#omniverse-isaac-sim)
  - [Natively](#natively-2)
  - [Docker (headless)](#docker-headless)

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

- Create and start the container

```bash
docker run --mount source=isaac-sdk-build-cache,target=/root -v `pwd`:/src/workspace -w /src/workspace/sdk -p 8888:8888 -p 3000:3000 --gpus all -it --name isaac isaacbuild:latest /bin/bash
```

- Build all Isaac SDK examples inside container (optional)

```bash
bazel build ...
```

- Access the stopped container

```bash
docker start -ai isaac
```

## Nucleus Server

Nucleus stores digital assets and virtual worlds for various Omniverse client applications. Clients can publish modification or subscribe to the changes of the assets in real time. To learn more, visit [Nucleus documentation](https://docs.omniverse.nvidia.com/prod_nucleus/prod_nucleus/overview.html).

### Natively

To install Nucleus Server in Linux, follow the [guide](https://docs.omniverse.nvidia.com/app_isaacsim/app_isaacsim/setup.html#nucleus-installation) in Omniverse documentation.

### Docker

Note that additional access is needed for NGC Omniverse Containers. Contact your NVIDIA's point person to have the access enabled.

- Login into NGC

```bash
docker login nvcr.io
```

- Install [docker-compose](https://docs.docker.com/compose/install/).

- Download and extract the Nucleus Core compose files from [Nucleus](https://docs.omniverse.nvidia.com/prod_nucleus/prod_nucleus/docker/index.html).

- Read `nucleus-stack.env` **CAREFULLY** to set correct environment variables.

  - Set correct host IP `EXTERNAL_IP_OR_HOST`.
  - Set a name for the instance `INSTANCE_NAME`.
  - Set password for superuser.
  - Set the desired data storage location `DATA_ROOT`.
  - Check port and container subnet has no conflicts with the host system.

- Generate secret set (**INSECURE**)

```bash
./generate-sample-insecure-secrets.sh
```

- Start the server with docker-compose to test everything works

```bash
docker-compose --env-file <.env file path> -f <.yml file path> up

# Add -d option to ‘daemonize’ stack
```

- Errors on Startup:

  - Give it some time to let docker restart containers to meet all dependencies
  - Check firewall status

- Follow [guide](https://docs.omniverse.nvidia.com/app_isaacsim/app_isaacsim/setup.html#adding-samples-assets) to add sample assets to Nucleus Server.

## Omniverse Isaac Sim

Omniverse Isaac Sim can run either natively or in a docker. It requires RTX-enabled GPUs for the best rendering.

### Natively

To run Omniverse Isaac Sim in local environment natively, follow the [guide](https://docs.omniverse.nvidia.com/app_isaacsim/app_isaacsim/setup.html#local-workstation-deployment) in Omniverse Isaac Sim documentation. Running natively is recommended at current stage.

### Docker (headless)

Note that the docker version is in **Early Access**. Each Omniverse Kit instance can only connect to one Omniverse Kit Remote Client. By default, the window size is 1280x720.

- Login into NGC

```bash
docker login nvcr.io
```

- Create and start the container

```bash
docker run --gpus all -e "ACCEPT_EULA=Y" -p 47995-48012:47995-48012/udp -p 47995-48012:47995-48012/tcp -p 49000-49007:49000-49007/tcp -p 49000-49007:49000-49007/udp -p 55000-55001:55000-55001 --name omniverse nvcr.io/nvidia/isaac-sim:2020.2_ea
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

- Start and stop a instance

```bash
docker start omniverse
docker stop omniverse
```
