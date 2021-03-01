docker run -it \
    --mount source=isaac-sdk-build-cache,target=/root \
    -v $(pwd):/src/workspace \
    -w /src/workspace/sdk \
    --gpus all \
    --name isaac_sdk \
    isaacbuild:latest /bin/bash
