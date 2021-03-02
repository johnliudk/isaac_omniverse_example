# JetBot <!-- omit in toc -->

- [About JetBot](#about-jetbot)
- [Remote control in simulator](#remote-control-in-simulator)
  - [Start Isaac SDK app](#start-isaac-sdk-app)
  - [Start Simulation](#start-simulation)
  - [Control JetBot](#control-jetbot)

## About JetBot

JetBot is the perfect platform to learn robotics with Isaac SDK and Omniverse Isaac Sim. JetBot is a DIY autonomous deep learning robotics kit, which is programmable through Jupyter Notebooks.

<img src="img/jetson-jetbot-illustration_1600x1260.png" height="256">

- More about [JetBot](https://jetbot.org/master/).
- Official tutorial from [Isaac SDK](https://docs.nvidia.com/isaac/isaac/doc/tutorials/jetbot.html) and [Omniverse Isaac Sim](https://docs.omniverse.nvidia.com/app_isaacsim/app_isaacsim/first_run.html).

## Remote control in simulator

### Start Isaac SDK app

- Run the `jetbot_jupyter_notebook` Jupyter notebook app and open the link in the browser

```bash
bazel run apps/jetbot:jetbot_jupyter_notebook
```

- Edit `simulation_tcp.subgraph.json` to set the correct host for `TcpSubscriber`

- Run `Remote control Jetbot using Virtual gamepad` section in `jetbot_notebook` to block `app.start()`

### Start Simulation

- Open `omni:/Isaac/Samples/Isaac_SDK/Robots/Jetbot_REB.usd` in Isaac Sim

- Edit `_build/linux-x86_64/release/exts/omni.isaac.robot_engine_bridge/resources/isaac_engine/json/isaacsim.app.json` to set the correct host for `TcpSubscriber`

- Create Robot Engine Bridge application

### Control JetBot

- Go to `<Isaac_SDK_IP>:3000` to interact with JetBot using Virtual Gamepad
