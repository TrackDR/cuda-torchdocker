# Start with CUDA base image
# modified kaixhin/cuda-torch

FROM kaixhin/cuda

# Install curl and dependencies for iTorch
RUN apt-get update && apt-get install -y \
  curl \
  ipython \
  python-zmq
# Run Torch7 installation scripts
RUN curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN cd ~/torch; ./install.sh
# Export paths
ENV PATH=/root/torch/install/bin:$PATH \
  LD_LIBRARY_PATH=$HOME/torch/install/lib:$LD_LIBRARY_PATH \
  DYLD_LIBRARY_PATH=$HOME/torch/install/lib:$DYLD_LIBRARY_PATH
# Set ~/torch as working directory
WORKDIR /root/torch
