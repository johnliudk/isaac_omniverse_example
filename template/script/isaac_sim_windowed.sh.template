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
