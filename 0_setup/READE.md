# Setup <!-- omit in toc -->

- [Docker and NVIDIA Container Toolkit](#docker-and-nvidia-container-toolkit)
- [Isaac SDK](#isaac-sdk)
  - [Natively](#natively)
  - [Docker](#docker)
- [Omniverse Isaac Sim](#omniverse-isaac-sim)
  - [Natively](#natively-1)
  - [Docker (Headless)](#docker-headless)

## Docker and NVIDIA Container Toolkit
Follow the [installation guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) of NVIDIA Container Toolkit to install both Docker-CE and NVIDIA Container Toolkit.

## Isaac SDK
Isaac SDK can run either natively or in a docker. Running natively is recommended for plug-and-play equipment.

### Natively
To run Isaac SDK in local environment natively, follow the [guide](https://docs.nvidia.com/isaac/isaac/doc/setup.html) in Isaac SDK documentation.

### Docker
* Create Image
```bash
cd isaac
engine/build/docker/create_image.sh
```

* Create cache volume for faster builds
```bash
docker volume create isaac-sdk-build-cache
```

* Create and start the container
```bash
docker run --mount source=isaac-sdk-build-cache,target=/root -v `pwd`:/src/workspace -w /src/workspace -p 8888:8888 -p 3000:3000 --gpus all -it --name isaac isaacbuild:latest /bin/bash
```

* Build Isaac SDK examples inside container (optional)
```bash
bazel build ...
```

* Access the stopped container
```bash
docker start -ai isaac
```

## Omniverse Isaac Sim
Omniverse Isaac Sim can run either natively or in a docker, as it requires powerful GPUs for rendering, a remote server may be a better choice.

### Natively
To run Omniverse Isaac Sim in local environment natively with Nucleus Deployment, follow the [guide](https://docs.omniverse.nvidia.com/app_isaacsim/app_isaacsim/setup.html#local-workstation-deployment) in Omniverse Isaac Sim documentation.

### Docker (Headless)
Note that each Omniverse Kit instance can only connect to one Omniverse Kit Remote Client. By default, the window size is 1280x720.

* Login into NGC
```bash
docker login nvcr.io
```

* Create and start the container
```bash
docker run --gpus all -e "ACCEPT_EULA=Y" -p 47995-48012:47995-48012/udp -p 47995-48012:47995-48012/tcp -p 49000-49007:49000-49007/tcp -p 49000-49007:49000-49007/udp -p 55000-55001:55000-55001 --name omniverse nvcr.io/nvidia/isaac-sim:2020.2_ea
```

* Download Omniverse Kit Rremote Clients on client machine from [Isaac Sim 2020.2 (Omniverse Early Access)](https://developer.nvidia.com/isaac-sim/download) and install requried packages:
```bash
sudo apt-get install libavcodec57 libavformat57 libavutil55 libsdl2-dev libsdl2-2.0-0
```

* Access Omniverse Kit instance
```bash
./omniverse-kit-remote.sh -s <remote_ip_address>
```

* Start and stop a instance
```bash
docker start omniverse
docker stop omniverse
```