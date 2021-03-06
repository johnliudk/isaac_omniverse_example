FROM nvcr.io/nvidia/isaac-sim:2020.2.2_ea

RUN apt update && apt upgrade -y
RUN apt install python3-pip vim git -y

RUN pip3 install --upgrade pip

RUN pip3 install \
    torch==1.4 \
    torchvision==0.5.0 \
    matplotlib==3.3.4 \
    requests==2.25.1 \
    six==1.15.0 \
    opencv-python==4.5.1.48 \
    scipy==1.4.1 \
    gym==0.18.0 \
    stable-baselines3==0.8.0 \
    tensorflow-gpu==2.3.0 \
    tensorflow-estimator==2.3.0 \
    tensorboard==2.3.0 \
    tensorboard-plugin-wit==1.7.0 \
    pillow==7.2.0 \
    numpy==1.18.5 \
    numpy-quaternion==2020.5.19.15.27.24

COPY ./patch/omnikit.py /isaac-sim/_build/linux-x86_64/release/exts/omni.isaac.synthetic_utils/omni/isaac/synthetic_utils/scripts

COPY ./patch/jetbot/isaacsim_patch/syntheticdata.py /isaac-sim/_build/linux-x86_64/release/exts/omni.isaac.synthetic_utils/omni/isaac/synthetic_utils/scripts
COPY ./patch/jetbot/isaacsim_patch/jetbot_env.py /isaac-sim/python_samples/jetbot
COPY ./patch/jetbot/isaacsim_patch/jetbot_train.py /isaac-sim/python_samples/jetbot
COPY ./patch/jetbot/isaacsim_patch/jetbot.py /isaac-sim/python_samples/jetbot
COPY ./patch/jetbot/isaacsim_patch/road_environment.py /isaac-sim/python_samples/jetbot

WORKDIR /isaac-sim/python_samples
COPY ./patch/entrypoint.sh .

RUN ln -s /usr/local/cuda-10.1/lib64/libcudart.so.10.1 /usr/lib/libcudart.so
RUN python3 setup.py install

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
