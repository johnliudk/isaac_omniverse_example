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
