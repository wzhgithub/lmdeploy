FROM ncr.nioint.com/docker.io/openmmlab/lmdeploy:v0.5.3-cu12

# Should be in the lmdeploy root directory when building docker image
COPY . /opt/lmdeploy

WORKDIR /opt/lmdeploy
ENV https_proxy=http://proxy.nioint.com:8080

RUN --mount=type=cache,target=/root/.cache/pip cd /opt/lmdeploy &&\
    python3 -m pip install -r requirements.txt &&\
    mkdir -p build && cd build &&\
    sh ../generate.sh &&\
    ninja -j$(nproc) && ninja install &&\
    cd .. &&\
    python3 -m pip install -e . &&\
    rm -rf build && \
    pip cache purge

ENV LD_LIBRARY_PATH=/opt/lmdeploy/install/lib:$LD_LIBRARY_PATH
ENV PATH=/opt/lmdeploy/install/bin:$PATH

# explicitly set ptxas path for triton
ENV TRITON_PTXAS_PATH=/usr/local/cuda/bin/ptxas
