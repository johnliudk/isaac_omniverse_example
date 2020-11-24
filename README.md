# isaac_omniverse_example <!-- omit in toc -->

- [Introduction](#introduction)
  - [Isaac SDk](#isaac-sdk)
  - [Omniverse Isaac Sim](#omniverse-isaac-sim)
- [Requirements](#requirements)
- [Usage](#usage)


## Introduction
### Isaac SDk
Isaac is NVIDIA’s open platform for intelligent robots. The Isaac SDK provides a large collection of powerful GPU-accelerated algorithm GEMs for navigation and manipulation. Isaac SDK Engine is a framework to easily write modular applications and deploy them on a real robot. Isaac SDK comes with various example applications from basic samples that show specific features to applications that facilitate complicated robotics use cases. Isaac SDK also works hand-in-hand with Isaac SIM, which allows for development, testing, and training of robots in a virtual environment.

### Omniverse Isaac Sim
Isaac Sim is built on NVIDIA’s Omniverse simulation platform, it leverages Omniverse Kit and has been enhanced with robotics specific extensions. Isaac Sim provides the essential features for building virtual robotic worlds and experiments. Isaac Sim supports navigation and manipulation applications through Isaac SDK and ROS, with RGB-D, Lidar and IMU sensors, Domain Randomization, ground truth labeling, segmentation, and bounding boxes.

Isaac Sim is part of the Omniverse Robotics Experience.

## Requirements
* [Isaac SDK 2020.1 NX](https://developer.nvidia.com/isaac/downloads)
* [Isaac Sim 2020.2 (Omniverse Early Access)](https://developer.nvidia.com/isaac-sim/download)
* [ROS Melodic](http://wiki.ros.org/melodic) (optional)
* [Docker-CE](https://docs.docker.com/engine/install/ubuntu/)
* [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker)

## Usage
* Setup the environment following the guide in [0_steup](0_setup/README.md).
* Follow the document of Isaac SDK and Isaac Sim for setup and basic understanding of the tools.
* Clone this repository to the `app` folder under Isaac SDK, by default `~/isaac/apps`. Follow the guide in each sub folders.